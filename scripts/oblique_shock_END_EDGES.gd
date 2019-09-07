#Copyright (c) 2019 Mehdi Msayib#
extends Node2D



var m_dataset=global_var.m_dataset
var p_p0_dataset=global_var.p_p0_dataset
var theta_dataset=global_var.theta_dataset

onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")

onready var checkbox_oblique_shock=get_parent().get_node("checkboxes/checkbox_oblique_shock")






func _interpolate(x1,x2,y1,y2,interp):
	var result=x1+((interp-y1)/(y2-y1))*(x2-x1)
	return result


func _dataset_search(interpVal,data1,data2):

	##### index= the number of the element at which condition is met ####


	var index=0 #index= the number of the element at which condition is met
	var minValdata1=0 # min value used in interpolation for data1 (i.e. 'x1')
	var maxValdata1=0 # max value used in interpolation for data1 (i.e. 'x2')
	var minValdata2=0 # min value used in interpolation for data2 (i.e. 'y1')
	var maxValdata2=0 # max value used in interpolation for data2 (i.e. 'y2')


	for i in range (len(data1)):
		if interpVal>data1[i]:
			pass
		else:
			index=i-1
			minValdata1=data2[index]
			maxValdata1=data2[index+1]
			minValdata2=data1[index]
			maxValdata2=data1[index+1]
			break

	return [index,minValdata1,maxValdata1,minValdata2,maxValdata2]







func _oblique_shock_END_EDGE(plate):
	var state=null
	var m=0
	var deflection_angle=0
	var m2=0
	var p2_p0=0
	var theta2=0
	var p2_p1=0

	if plate=="top":
		m=global_var.list_m.back()
		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate]
	if plate=="bottom":
		m=global_var.list_m[global_var.index_bottom_top_plate-1]
		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate-1]


	if deflection_angle<_plot_curve_END_EDGE(m).max()*0.93:
		m2=clamp(_m2_END_EDGE(m,plate),0,global_var.m1)
		p2_p0=_interpolate(_dataset_search(m2,m_dataset,p_p0_dataset)[1],_dataset_search(m2,m_dataset,p_p0_dataset)[2],_dataset_search(m2,m_dataset,p_p0_dataset)[3],_dataset_search(m2,m_dataset,p_p0_dataset)[4],m2)
		theta2=_interpolate(_dataset_search(m2,m_dataset,theta_dataset)[1],_dataset_search(m2,m_dataset,theta_dataset)[2],_dataset_search(m2,m_dataset,theta_dataset)[3],_dataset_search(m2,m_dataset,theta_dataset)[4],m2)
		p2_p1=_p_p1_END_EDGE(m,plate)
		
		if plate=="top":
			global_var.m2_END_EDGE_TOP=m2
			global_var.p2_p0_END_EDGE_TOP=p2_p0
			global_var.theta2_END_EDGE_TOP=theta2
			global_var.p2_p1_END_EDGE_TOP=p2_p1
			state=true
			
		if plate=="bottom":
			global_var.m2_END_EDGE_BOTTOM=m2
			global_var.p2_p0_END_EDGE_BOTTOM=p2_p0
			global_var.theta2_END_EDGE_BOTTOM=theta2
			global_var.p2_p1_END_EDGE_BOTTOM=p2_p1
			state=true
		
	else:
		print("too large def angle")
		state=false
		
	return state








func _plot_curve_END_EDGE(m): #ok

	var points=100
	var beta_array_initial=[]
	var theta_array_initial=[]


	beta_array_initial=global_var._linspace(deg2rad(0.1),deg2rad(100),points)
	theta_array_initial=global_var._linspace(0,0,points)

	for i in range(len(beta_array_initial)):

		theta_array_initial[i]=atan(_Equation__flowDeflection_shockAngle_END_EDGE(beta_array_initial[i],m))
		
	return theta_array_initial




func _m2_END_EDGE(m,plate): #ok
	var m2n=sqrt(((global_var.gamma-1)*pow(m,2)*pow(sin(_shock_angle_END_EDGE(m,plate)),2) +2)/((2*global_var.gamma*pow(m,2)*pow(sin(_shock_angle_END_EDGE(m,plate)),2))-(global_var.gamma-1)))
	var m2=0
	
	if plate=="top":
		m2n/(sin(_shock_angle_END_EDGE(m,plate)-global_var.list_GlobalAngles[global_var.index_bottom_top_plate]))
		
	if plate=="bottom":
		m2n/(sin(_shock_angle_END_EDGE(m,plate)-global_var.list_GlobalAngles[global_var.index_bottom_top_plate-1]))
		
	return m2



func _p_p1_END_EDGE(m,plate): #ok
	var p_p1=(1/(global_var.gamma+1)) * (2*global_var.gamma*pow(m,2)*pow(sin(_shock_angle_END_EDGE(m,plate)),2) -(global_var.gamma-1))
	return p_p1



func _Equation__flowDeflection_shockAngle_END_EDGE(mpoint,m): #ok

	var eqn=(2*(1/tan(mpoint))*(pow(m,2)*pow(sin(mpoint),2) -1))/(pow(m,2)*(global_var.gamma+cos(2*mpoint)) +2)
	return eqn
	
	

func _shock_angle_END_EDGE(m,plate): #ok

	
	var deflection_angle=0
	
	if plate=="top":
		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate]
	if plate=="bottom":
		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate-1]
	
	var setpoint=tan(deflection_angle)
	var resolution=global_var.simulation_precision
	var minVal=deg2rad(0)
	var maxVal=deg2rad(85)
	var val=[minVal,maxVal]
	var mpoint=(val[0]+val[1])*0.5
	var shock_angle=0
	#var iterations=0


	if deflection_angle<_plot_curve_END_EDGE(m).max()*0.93:
		while abs(_Equation__flowDeflection_shockAngle_END_EDGE(mpoint,m)-setpoint)>resolution:
	
			#iterations+=1
			mpoint=(val[0]+val[1])*0.5
			if _Equation__flowDeflection_shockAngle_END_EDGE(mpoint,m)>setpoint:
			    val[1]=mpoint
			if _Equation__flowDeflection_shockAngle_END_EDGE(mpoint,m)<setpoint:
			    val[0]=mpoint
	
		shock_angle=(val[0]+val[1])*0.5
		
		if plate=="top":
			global_var.weak_shock_END_EDGE_TOP=shock_angle
		if plate=="bottom":
			global_var.weak_shock_END_EDGE_BOTTOM=shock_angle
	else:
		print("Error! Deflection (weak shock) angle too large for the given flow condtions (try decreasing aerofoil thickness and lowering speed).")
		
		
	return shock_angle











func _on_alpha_slider_value_changed(value):
	
	for i in 2:
		if _oblique_shock_END_EDGE("top")==true:
			_oblique_shock_END_EDGE("top")
		else:
			break
			
		var grad=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
		if sign(grad)==1: # to prevent exp fan showing if tehre is an oblique shock line
			if _oblique_shock_END_EDGE("bottom")==true:
				_oblique_shock_END_EDGE("bottom")
			else:
				break
				
				
	print(global_var.p2_p1_END_EDGE_TOP, "   ",global_var.p2_p1_END_EDGE_BOTTOM)
		
	
	pass # Replace with function body.


















































#func _oblique_shock_BOTTOM_EDGE(i): #done
#	var state=null
#	var m=0
#	var deflection_angle=0
#
#	if i==0: #bottom edge plate
#		m=global_var.list_m[global_var.index_bottom_top_plate-1]
#		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate-1]
#
#	if i==1: #top edge plate
#		m=global_var.list_m.back()
#		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate]
#
#	if deflection_angle<_plot_curve(m).max()*0.93:
#		var m2=clamp(_m2(m,i),0,global_var.m1)
#		var p2_p0=_interpolate(_dataset_search(m2,m_dataset,p_p0_dataset)[1],_dataset_search(m2,m_dataset,p_p0_dataset)[2],_dataset_search(m2,m_dataset,p_p0_dataset)[3],_dataset_search(m2,m_dataset,p_p0_dataset)[4],m2)
#		var theta2=deg2rad(_interpolate(_dataset_search(m2,m_dataset,theta_dataset)[1],_dataset_search(m2,m_dataset,theta_dataset)[2],_dataset_search(m2,m_dataset,theta_dataset)[3],_dataset_search(m2,m_dataset,theta_dataset)[4],m2))
#		var p2_p1=_p_p1(m,i)
#
#		if i==0: #bottom edge plate
#			global_var.m2_END_EDGE_BOTTOM=m2
#			global_var.p2_p0_END_EDGE_BOTTOM=p2_p0
#			global_var.theta2_END_EDGE_BOTTOM=theta2
#			global_var.p2_p1_END_EDGE_BOTTOM=p2_p1
#
#		if i==1: #top edge plate
#			global_var.m2_END_EDGE=m2
#			global_var.p2_p0_END_EDGE=p2_p0
#			global_var.theta2_END_EDGE=theta2
#			global_var.p2_p1_END_EDGE=p2_p1
#
#		state=true
#
#
#	else:
#		print("too large def angle, 'oblique_shock_END_EDGES'")
#		state=false
#
#	return state
#
#
#
#
#func _m2(m,i): #done
#	var m2n=sqrt(((global_var.gamma-1)*pow(m,2)*pow(sin(_shock_angle(m,i)),2) +2)/((2*global_var.gamma*pow(m,2)*pow(sin(_shock_angle(m,i)),2))-(global_var.gamma-1)))
#	var m2=0
#
#	if i==0: #bottom edge plate
#		m2=m2n/(sin(_shock_angle(m,i)-global_var.list_GlobalAngles[global_var.index_bottom_top_plate-1]))
#
#	if i==1: #top edge plate
#		m2=m2n/(sin(_shock_angle(m,i)-global_var.list_GlobalAngles[global_var.index_bottom_top_plate]))
#
#	return m2
#
#
#
#func _shock_angle(m,i):#done
#
############WEAK SHOCK###########
#
#	var deflection_angle=0
#
#	if i==0: #bottom edge plate
#		m=global_var.list_m[global_var.index_bottom_top_plate-1]
#		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate-1]
#
#	if i==1: #top edge plate
#		m=global_var.list_m.back()
#		deflection_angle=global_var.list_GlobalAngles[global_var.index_bottom_top_plate]
#
#	var setpoint=tan(deflection_angle)
#	var resolution=global_var.simulation_precision
#	var minVal=0
#	var maxVal=deg2rad(90)
#	var val=[minVal,maxVal]
#	var mpoint=(val[0]+val[1])*0.5
#	var shock_angle=0
#	#var iterations=0
#
#
#	if deflection_angle<_plot_curve(m).max()*0.93:
#		while abs(_Equation__flowDeflection_shockAngle(mpoint,m)-setpoint)>resolution:
#
#			#iterations+=1
#			mpoint=(val[0]+val[1])*0.5
#			if _Equation__flowDeflection_shockAngle(mpoint,m)>setpoint:
#			    val[1]=mpoint
#			if _Equation__flowDeflection_shockAngle(mpoint,m)<setpoint:
#			    val[0]=mpoint
#
#		shock_angle=(val[0]+val[1])*0.5
#		if i==0:
#			global_var.weak_shock_END_EDGE_BOTTOM=shock_angle
#		if i==1:
#			global_var.weak_shock_END_EDGE=shock_angle
#	else:
#		print("Error! Deflection (weak shock) angle too large for the given flow condtions (try decreasing aerofoil thickness and lowering speed).")
#
#
#	return shock_angle
#
#
#
#func _plot_curve(m):
#
#	var points=100
#	#var indexi=0
#	#var startingpoint=0
#	var beta_array_initial=[]
#	#var beta_array_final=[]
#	var theta_array_initial=[]
#	#var theta_array_final=[]
#
#
#	beta_array_initial=global_var._linspace(deg2rad(0.1),deg2rad(100),points)
#	theta_array_initial=global_var._linspace(0,0,points)
#
#	for i in range(len(beta_array_initial)):
#
#		theta_array_initial[i]=atan(_Equation__flowDeflection_shockAngle(beta_array_initial[i],m))
#
#
#	return theta_array_initial
#
#
#func _p_p1(m,i): #done
#	#var angle=list_deflection_angle[ii]+shock_angle
#	var p_p1=(1/(global_var.gamma+1)) * (2*global_var.gamma*pow(m,2)*pow(sin(_shock_angle(m,i)),2) -(global_var.gamma-1))
#	return p_p1
#
#
#
#func _Equation__flowDeflection_shockAngle(mpoint,m): #done
#
#	var eqn=(2*(1/tan(mpoint))*(pow(m,2)*pow(sin(mpoint),2) -1))/(pow(m,2)*(global_var.gamma+cos(2*mpoint)) +2)
#	return eqn
#
#
#
#
#func _on_alpha_slider_value_changed(value):
#
#	if checkbox_oblique_shock.pressed==true or global_var.button_advanced_popup_index==0 or global_var.button_advanced_popup_index==1 or global_var.button_advanced_popup_index==7 :
#		if global_var.bow_shock_angle==10 or (global_var.bow_shock_angle>0 and value<global_var.bow_shock_angle):
#
#			yield(get_tree(),"idle_frame")
#			yield(get_tree(),"idle_frame")
#			yield(get_tree(),"idle_frame")
#
#			#_oblique_shock_BOTTOM_EDGE(0)
#			_oblique_shock_BOTTOM_EDGE(1)
#
#			#print(global_var.m2_END_EDGE_BOTTOM," ",global_var.m2_END_EDGE)
#			print(global_var.p2_p1_END_EDGE_BOTTOM," ",global_var.p2_p1_END_EDGE)
##				else:
##					print("oblique break, 'oblique_shock_END_EDGES'")
#	pass # Replace with function body.
#
#
#
#func _on_m_slider_button_button_up():
#	if checkbox_oblique_shock.pressed==true or global_var.button_advanced_popup_index==0 or global_var.button_advanced_popup_index==1 or global_var.button_advanced_popup_index==7 :
#		if (float(global_var.bow_shock_angle)+1.0)!=1.1:
#			_oblique_shock_BOTTOM_EDGE(0)
#			_oblique_shock_BOTTOM_EDGE(1)
#	pass # Replace with function body.
#
#
#func _on_gamma_slider_button_button_up():
#	if checkbox_oblique_shock.pressed==true or global_var.button_advanced_popup_index==0 or global_var.button_advanced_popup_index==1 or global_var.button_advanced_popup_index==7 :
#		if (float(global_var.bow_shock_angle)+1.0)!=1.1:
#
#			yield(get_tree(),"idle_frame")
#			yield(get_tree(),"idle_frame")
#			yield(get_tree(),"idle_frame")
#			_oblique_shock_BOTTOM_EDGE(0)
#			_oblique_shock_BOTTOM_EDGE(1)
#	pass # Replace with function body.



