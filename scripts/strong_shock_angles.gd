#Copyright (c) 2019 Mehdi Msayib#
extends ItemList
#
var points=500



func _ready():
	get_parent().hide()



func _plot_curve(index):

	var m=0
	
	if index==0:
		m=global_var.m1
	if index>0 and global_var.list_position[index]==global_var.list_position[index-1]:
		m=global_var.list_m[index-1]
	if index>0 and global_var.list_position[index]!=global_var.list_position[index-1]:
		m=global_var.m1


	var beta_array_initial=[]
	var theta_array_initial=[]

	beta_array_initial=global_var._linspace(deg2rad(0.01),deg2rad(100),points)

	for i in range(len(beta_array_initial)):
		theta_array_initial.append(atan(global_var._Equation__flowDeflection_shockAngle(beta_array_initial[i],m)))

	return theta_array_initial






func _strong_shock(index):

	var m=0
	
	if index==0:
		m=global_var.m1
	if index>0 and global_var.list_position[index]==global_var.list_position[index-1]:
		m=global_var.list_m[index-1]
	if index>0 and global_var.list_position[index]!=global_var.list_position[index-1]:
		m=global_var.m1

	var resolution=global_var.simulation_precision
	var deflection_angle=global_var.list_deflection_angle[index]
	var setpoint=tan(deflection_angle)

	var theta_array_final=_plot_curve(index)
	var beta_array_final=global_var._linspace(deg2rad(0.01),deg2rad(100),points)
	var minVal=0
	var maxVal=0

	var init_index=0

	for i in range(len(theta_array_final)):
		if theta_array_final[i]>deflection_angle:
			minVal=beta_array_final[i-6]
			maxVal=beta_array_final[i]
			#print("1",rad2deg(theta_array_final[i])," ",rad2deg(deflection_angle))
			init_index=i
			break



	for i in range(len(theta_array_final)):
		if theta_array_final[i]<deflection_angle and i>init_index:
			minVal=beta_array_final[i+10]
			maxVal=beta_array_final[i-10]
			#print(i, "  ",rad2deg(theta_array_final[i])," ",rad2deg(deflection_angle)," ",rad2deg(minVal)," ",rad2deg(maxVal))
			#init_index=i
			break





	var val=[minVal,maxVal]
	var mpoint=(val[0]+val[1])*0.5

	#print(counter)

	if deflection_angle<global_var._max(_plot_curve(index))*0.93:
		while abs(global_var._Equation__flowDeflection_shockAngle(mpoint,m)-setpoint)>resolution:
	
			mpoint=(val[0]+val[1])*0.5
			if global_var._Equation__flowDeflection_shockAngle(mpoint,m)>setpoint:
			    val[1]=mpoint
			if global_var._Equation__flowDeflection_shockAngle(mpoint,m)<setpoint:
			    val[0]=mpoint
	else:
		print("Error! Deflection (weak shock) angle too large for the given flow condtions (try decreasing aerofoil thickness and lowering speed).")


	var strong_shock_angle=(val[0]+val[1])*0.5
	global_var.list_strong_shock_angle[index]=strong_shock_angle
	#print("strong shock",rad2deg(strong_shock_angle)," ","weak shock",rad2deg(global_var.list_weak_shock_angle[index])," ","deflection angle",rad2deg(global_var.list_deflection_angle[index]))
	print(rad2deg(strong_shock_angle),"      ",rad2deg(global_var.list_weak_shock_angle[index]),"      ",rad2deg(global_var.list_deflection_angle[index]))
	return strong_shock_angle









func _on_alpha_slider_value_changed(value):


	if get_parent().visible==true:
		
		for i in len(global_var.list_strings):
			if global_var.list_strings[i]=="contraction":
				_strong_shock(i)
			
		clear()
		for i in len(global_var.list_strong_shock_angle):
			add_item("Plate"+str(i)+" : "+str(stepify(global_var.list_strong_shock_angle[i],0.01)),null,false)




	pass # Replace with function body.











