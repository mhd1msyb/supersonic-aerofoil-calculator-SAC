#Copyright (c) 2019 Mehdi Msayib#
extends Node2D


onready var checkbox_shock_vs_deflec_curve=get_parent().get_node("checkboxes").get_node("checkbox_shock_vs_deflec_curve")



func _draw_x_y_axes(origin,pixel_limit):
	
	var colour=Color(0.9,1,0)
	#var origin=Vector2(OS.window_size.x/2-200,OS.window_size.y/2 + 200)
	var origin_vec=origin#Vector2(50,80)
	var pix_limit=pixel_limit

	var xAxis=origin+Vector2(pix_limit,0)
	var yAxis=origin-Vector2(0,pix_limit)
	
	draw_line(origin,xAxis,colour,3)#xaxis line
	draw_line(origin,yAxis,colour,3)#yaxis line
	
	

func _draw_plot_curve(point_count,point_scale,origin_vector):

	var points=point_count
	var indexi=0
	var origin_vec=origin_vector
	var startingpoint=0
	var beta_array_initial=[]
	var beta_array_final=[]
	var theta_array_initial=[]
	var theta_array_final=[]
	var plot_coords=[]

	beta_array_initial=global_var._linspace(deg2rad(1),deg2rad(90),points)
	theta_array_initial=global_var._linspace(0,0,points)

	for i in range(len(beta_array_initial)):

		theta_array_initial[i]=atan(global_var._Equation__flowDeflection_shockAngle(beta_array_initial[i],global_var.m1))
		
		
	for i in range(len(beta_array_initial)):
		if theta_array_initial[i-1]<0 and theta_array_initial[i]>0:
			indexi=i-1
			startingpoint=theta_array_initial[indexi]
			break


	beta_array_final= global_var._linspace(beta_array_initial[indexi],deg2rad(90),points)
	theta_array_final=global_var._linspace(0,0,points)

	for i in range(len(beta_array_final)):
		theta_array_final[i]=atan(global_var._Equation__flowDeflection_shockAngle(beta_array_final[i],global_var.m1))
		
		var vec=Vector2(theta_array_final[i]*point_scale,beta_array_final[i]*point_scale)+origin_vec
	
		plot_coords.append(vec)
	return plot_coords
	
	
	
	
func _draw_shock_vs_deflection_curve():

	var colour=Color(0,1,0.5)
	#var origin=Vector2(OS.window_size.x/2-200,OS.window_size.y/2 + 200)
	var origin=Vector2(800,20)#Vector2(50,80)
	var point_scale=100
	
	#var origin=Vector2(OS.window_size.x/2-200,OS.window_size.y/2 + 200)
	var point_coords=_draw_plot_curve(100,point_scale,origin)
	#print(point_coords)
	draw_polyline(point_coords,colour,2)#xaxis line

	_draw_x_y_axes(origin+Vector2(0,100),point_scale)
	
	
	
func _draw():
	if checkbox_shock_vs_deflec_curve.pressed:
		_draw_shock_vs_deflection_curve()
	


func _on_m_slider_value_changed(value):
	if checkbox_shock_vs_deflec_curve.pressed:
		update()
	pass # replace with function body
