#Copyright (c) 2019 Mehdi Msayib#
extends Node2D

#isentropic data from DATASET#######
onready var m_dataset=global_var.m_dataset
onready var p_p0_dataset=global_var.p_p0_dataset
onready var theta_dataset=global_var.theta_dataset

var alpha=0 # defined by the user

var horizontal_vector=Vector2(1,0)
onready var viewport_vec=global_var.viewport_vec
onready var screen_center=viewport_vec*0.5

var cL_coeff_lift=0
var cD_coeff_drag=0


onready var pivot =get_node("pivot")
onready var line2d_bottom=get_child(0).get_node("Line2D_bottom")


onready var preload_proxy=preload("res://scenes/proxy_expansion_fan.tscn")

onready var chord_vec2=Vector2(pivot.global_transform.x.normalized().x,pivot.global_transform.x.normalized().y)

onready var m_slider=get_node("m_slider_button")
onready var alpha_slider=get_node("alpha_slider")
onready var gamma_slider=get_node("gamma_slider_button")

onready var checkbox_shock_vs_deflec_curve=get_node("checkboxes").get_node("checkbox_shock_vs_deflec_curve")
onready var checkbox_cL_plot=get_node("checkboxes").get_node("checkbox_cL_plot")
onready var checkbox_cD_plot=get_node("checkboxes").get_node("checkbox_cD_plot")

onready var checkbox_oblique_shock_lines=get_node("checkboxes/checkbox_oblique_shock")
onready var checkbox_expansion_fans=get_node("checkboxes/checkbox_expansion_fan")


onready var finish_button=get_node("finish_button")
onready var undo_button=get_node("button_undo")
onready var edit_button=get_node("button_edit")
onready var save_button=get_node("button_save_aerofoil")
onready var advanced_button=get_node("button_advanced")
onready var generate_3d_mesh_button=get_node("button_generate_3d_mesh")


onready var chord_slider=get_node("chord_slider")
onready var thickness_slider=get_node("thickness_slider")



onready var preload_collison_node=preload("res://scenes/collision_node.tscn")

onready var aerofoil_choice_container=get_node("aerofoil_choice_container")

onready var rich_text=preload("res://scenes/rich_text.tscn")

onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")

<<<<<<< HEAD
onready var label=preload("res://scenes/label.tscn")

=======
>>>>>>> e0b9a79e02a3eff675aea345f23db5b087d0349e
onready var error_line_highlight=preload("res://scenes/error_line_highlight.tscn")

onready var label_please_wait=get_node("label_please_wait")

onready var polygon2d_initial_occluder=get_node("polygon2d_initial_occluder")

onready var error_log=get_node("error_log")
onready var error_log_message_box=get_node("error_log/VBoxContainer/background/ScrollContainer/message_box")


func _refresh_lists():

	
	global_var.list_position.clear()
	global_var.list_point_coords.clear()
	global_var.list_GlobalPointCoords.clear()
	#global_var.list_midpoint_pos.clear()
	global_var.list_vector.clear()
	global_var.list_LocalAngles.clear() # angle relative to chord (i.e. 'half_angle'). Only calculate when a node position is changed, and NOT every frame (as it remains constant)
	global_var.list_GlobalAngles.clear()# angle relative to horizontal
	global_var.list_strings.clear()
	global_var.list_p_p1.clear()
	global_var.list_p_p0.clear()
	global_var.list_theta.clear()
	global_var.list_deflection_angle.clear()
	global_var.list_m.clear()
	global_var.list_weak_shock_angle.clear()
	global_var.list_strong_shock_angle.clear()
	
	global_var.index_bottom_top_plate=0
	
	global_var.expansion_angle1=0
	global_var.expansion_angle2=0
	
	global_var.cn_pressures.clear()
	global_var.ca_pressures.clear()
	
	global_var.t_c=0
	global_var.t=0
	global_var.c=0
	
	
	global_var.cL=0
	global_var.cD=0
	
	global_var.cL_plot_list.clear()
	global_var.cD_plot_list.clear()
	
#	global_var.index_start_line_error=0
#
#	global_var.index_start_line_error=0
#
	global_var.bow_shock_angle=10
#
#	global_var.alpha_radians_plot_list.clear()
#
#	global_var.point_count_before_edit=0

func _clear_lists():#done
	
	#global_var.list_LocalAngles.clear()
	#global_var.list_GlobalAngles.clear()
	global_var.list_strings.clear()
	global_var.list_p_p1.clear()
	global_var.list_p_p0.clear()
	global_var.list_theta.clear()
	global_var.list_deflection_angle.clear()
	global_var.list_m.clear()
	global_var.list_weak_shock_angle.clear()
	#global_var.list_strong_shock_angle.clear()
	
	
	for i in range(line2d_bottom.get_point_count()-1):
		
		#global_var.list_LocalAngles.append(0)
		#global_var.list_GlobalAngles.append(0)
		global_var.list_strings.append("")
		global_var.list_p_p1.append(0)
		global_var.list_p_p0.append(0)
		global_var.list_theta.append(0)
		global_var.list_deflection_angle.append(0)
		global_var.list_m.append(0)
		global_var.list_weak_shock_angle.append(0)
		#global_var.list_strong_shock_angle.append(0)

	global_var.expansion_angle1=0
	global_var.expansion_angle2=0

	global_var.cL=0
	global_var.cD=0
	
#	global_var.cL_plot_list.clear()
#	global_var.cD_plot_list.clear()
	
	


func _plate_gradient(i):
	
	if global_var.list_vector[i].x<0.000001:
		var error_message=label.instance()
		error_log_message_box.add_child(error_message)
		error_message.text="""#Error! Plate gradients are too 
		steep. Press 'UNDO' and sketch 
		again.#"""
#		error_message.rect_size.x*=3
#		error_message.rect_global_position=alpha_slider.rect_global_position-Vector2(0,60)
		error_message.self_modulate=ColorN("orangered",1.0)
		error_log.show()
		print("STEEP GRADIENT",i)
		return 100000000000000
		
	else:
		var grad=-global_var.list_vector[i].y/global_var.list_vector[i].x
		return grad
	
	




func _initialise_lists():#done
	
	######used to create dynamically-sized list (based on number or plate), and initialise them############

	global_var.index_bottom_top_plate=0
	global_var.list_point_coords.clear()
	global_var.list_vector.clear()
	#global_var.list_midpoint_pos.clear()
	global_var.list_LocalAngles.clear() # angle relative to chord (i.e. 'half_angle'). Only calculate when a node position is changed, and NOT every frame (as it remains constant)
	global_var.list_GlobalAngles.clear()# angle relative to horizontal
	global_var.list_strings.clear()
	global_var.list_position.clear()
	global_var.list_p_p1.clear()
	global_var.list_p_p0.clear()
	global_var.list_theta.clear()
	global_var.list_deflection_angle.clear()
	global_var.list_m.clear()
	global_var.list_weak_shock_angle.clear()
	global_var.list_strong_shock_angle.clear()
	global_var.ca_pressures.clear()
	
	
	var index=0
	var point_count=line2d_bottom.get_point_count()
		
	for i in range(line2d_bottom.get_point_count()):# find index at which bottom plate changes to top
		if i<line2d_bottom.get_point_count()-1:
			if line2d_bottom.to_global(line2d_bottom.get_point_position(i+1)).x-line2d_bottom.to_global(line2d_bottom.get_point_position(i)).x<0:
				index=i
				global_var.index_bottom_top_plate=i
				#print(i)
				break
				
				
				
				
				
				
		
	for i in range (line2d_bottom.get_point_count()):# find list point coords
		if i<=index:#bottom plates
			global_var.list_point_coords.append( line2d_bottom.to_global(line2d_bottom.get_point_position(i)) )
		else: #top plates
			global_var.list_point_coords.append(line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index)))




	for i in range (len(global_var.list_point_coords)-1): # find list vectors
		if i<index:
			global_var.list_vector.append( (line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-line2d_bottom.to_global(line2d_bottom.get_point_position(i))).normalized() )
		else:
			if point_count-i+index-2>0:
				global_var.list_vector.append( (line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index-2))-line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index-1))).normalized() )
				#print(point_count-i+index)
				#global_var.list_vector.append(Vector2())
			else:
				global_var.list_vector.append( (line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index-2))-line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index-1))).normalized() )
			
			
			
			

	for i in range(len(global_var.list_point_coords)-1):


		#global_var.list_LocalAngles.append(0)
		global_var.list_GlobalAngles.append(0)
		global_var.list_strings.append("")
		global_var.list_position.append("")
		global_var.list_p_p1.append(0)
		global_var.list_p_p0.append(0)
		global_var.list_theta.append(0)
		global_var.list_deflection_angle.append(0)
		global_var.list_m.append(0)
		global_var.list_weak_shock_angle.append(0)
		global_var.list_strong_shock_angle.append(0)
		#global_var.list_midpoint_pos.append( Vector2( (line2d_bottom.global_transform.basis_xform(line2d_bottom.get_point_position(i)).x+(2*line2d_bottom.global_transform.origin.x)+line2d_bottom.global_transform.basis_xform(line2d_bottom.get_point_position(i+1)).x)*0.5, (line2d_bottom.global_transform.basis_xform(line2d_bottom.get_point_position(i)).y+(2*line2d_bottom.global_transform.origin.y)+line2d_bottom.global_transform.basis_xform(line2d_bottom.get_point_position(i+1)).y)*0.5))

	

#
		if sign(_plate_gradient(i))==-1:
			global_var.ca_pressures.append(1)
		if sign(_plate_gradient(i))==1:
			global_var.ca_pressures.append(-1)
		if sign(_plate_gradient(i))==0:
			global_var.ca_pressures.append(0)
		#print(_plate_gradient(i))
	
	for i in line2d_bottom.get_point_count():
		global_var.list_GlobalPointCoords.append(line2d_bottom.to_global(line2d_bottom.get_point_position(i)))
	
	
	
func _update_coords_vectors_midpoints():#done

	global_var.list_point_coords.clear() #clears the list
	global_var.list_vector.clear()
	#global_var.list_midpoint_pos.clear()

	var index=global_var.index_bottom_top_plate
	var point_count=line2d_bottom.get_point_count()
		
		
	for i in range (line2d_bottom.get_point_count()):# find list point coords
		if i<=index:#bottom plates
			global_var.list_point_coords.append( line2d_bottom.to_global(line2d_bottom.get_point_position(i)) )
		else: #top plates
			global_var.list_point_coords.append(line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index)))


	for i in range (len(global_var.list_point_coords)-1):
		if i<index:
			global_var.list_vector.append( (line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-line2d_bottom.to_global(line2d_bottom.get_point_position(i))).normalized() )
		else:
			global_var.list_vector.append( (line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index-2))-line2d_bottom.to_global(line2d_bottom.get_point_position(point_count-i+index-1))).normalized() )
			
			
			

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





func _top_or_bottom():
	
	####CALLED AFTER '_initialise_lists()' #######
	

	for i in range(len(global_var.list_vector)):

		###top plate
		if i<global_var.index_bottom_top_plate: # below
			global_var.list_position[i]="below"
		###bottom plate	
		else: # above
			global_var.list_position[i]="above"




func _define_expansion_contraction(i):

	if global_var.list_position[i]=="below":
		if i==0: # set initial plate to be contraction
			if stepify(_plate_gradient(i),0.0001)>0:
				global_var.list_strings[i]="expansion"
			if  stepify(_plate_gradient(i),0.0001)<0:
				global_var.list_strings[i]="contraction"
			if  stepify(_plate_gradient(i),0.0001)==0:
				global_var.list_strings[i]="nothing"
				
			
		if i>0:
			if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)>0:
				global_var.list_strings[i]="expansion"
			if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)<0:
				global_var.list_strings[i]="contraction"
			if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)==0:
				global_var.list_strings[i]="nothing"
			pass

	if global_var.list_position[i]=="above":
		if global_var.list_position[i-1]=="below":
			if stepify(_plate_gradient(i),0.0001)>0:
				global_var.list_strings[i]="contraction"
			if stepify(_plate_gradient(i),0.0001)<0:
				global_var.list_strings[i]="expansion"
			if stepify(_plate_gradient(i),0.0001)==0:
				global_var.list_strings[i]="nothing"
				
		if global_var.list_position[i-1]=="above":
			if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)>0:
				global_var.list_strings[i]="contraction"
			if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)<0:
				global_var.list_strings[i]="expansion"
			if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)==0:
				global_var.list_strings[i]="nothing"



func _deflection_angles(i):

	if global_var.list_position[i]=="below":
		if i==0: #if i-1<0 (i.e. starting plate, then calc angle w.r.t horizontal_vector)
			global_var.list_deflection_angle[i]=acos(global_var.list_vector[i].dot(horizontal_vector))
		else:
			global_var.list_deflection_angle[i]=acos(global_var.list_vector[i].dot(global_var.list_vector[i-1]))

	if global_var.list_position[i]=="above":
		if global_var.list_position[i-1]=="below": #if first top plate, then calc angle w.r.t horizontal_vector
			global_var.list_deflection_angle[i]=acos(global_var.list_vector[i].dot(horizontal_vector))
		else:
			global_var.list_deflection_angle[i]=acos(global_var.list_vector[i].dot(global_var.list_vector[i-1]))

	if global_var.list_strings[i]=="nothing":
		global_var.list_deflection_angle[i]=0



	#### if angle is greater than 90 , then make sure it's doesn't exceed 90, by doing pi/2 - angle (so angle is always between 0 and 90)###############

	if global_var.list_deflection_angle[i]>PI/2:
		global_var.list_deflection_angle[i]=abs(PI/2 -global_var.list_deflection_angle[i])
	elif global_var.list_deflection_angle[i]<=PI/2:
		global_var.list_deflection_angle[i]=global_var.list_deflection_angle[i]



func _p_p1(ii,m):
	#var angle=list_deflection_angle[ii]+shock_angle
	var p_p1=(1/(global_var.gamma+1)) * (2*global_var.gamma*pow(m,2)*pow(sin(_shock_angle(ii,m)),2) -(global_var.gamma-1))
	return p_p1


func _m2(ii,m):
	var m2n=sqrt(((global_var.gamma-1)*pow(m,2)*pow(sin(_shock_angle(ii,m)),2) +2)/((2*global_var.gamma*pow(m,2)*pow(sin(_shock_angle(ii,m)),2))-(global_var.gamma-1)))
	var m2=m2n/(sin(_shock_angle(ii,m)-global_var.list_deflection_angle[ii]))
	return m2



func _Equation__flowDeflection_shockAngle(mpoint,m):

	var eqn=(2*(1/tan(mpoint))*(pow(m,2)*pow(sin(mpoint),2) -1))/(pow(m,2)*(global_var.gamma+cos(2*mpoint)) +2)
	return eqn




func _plot_curve(m):

	var points=100
	#var indexi=0
	#var startingpoint=0
	var beta_array_initial=[]
	#var beta_array_final=[]
	var theta_array_initial=[]
	#var theta_array_final=[]


	beta_array_initial=global_var._linspace(deg2rad(0.1),deg2rad(100),points)
	theta_array_initial=global_var._linspace(0,0,points)

	for i in range(len(beta_array_initial)):

		theta_array_initial[i]=atan(_Equation__flowDeflection_shockAngle(beta_array_initial[i],m))
		
		
#		if theta_array_initial[i-1]<0 and theta_array_initial[i]>0:
#			indexi=i
#			startingpoint=theta_array_initial[i]
#			break
#
#
#	beta_array_final= _linspace(beta_array_initial[indexi],deg2rad(90),points)
#	theta_array_final=_linspace(0,0,points)
#
#	for i in range(len(beta_array_final)):
#		theta_array_final[i]=atan(_Equation__flowDeflection_shockAngle(beta_array_final[i],m))
	return theta_array_initial


func _shock_angle(index,m):

###########WEAK SHOCK###########


	var deflection_angle=global_var.list_deflection_angle[index]
	var setpoint=tan(deflection_angle)
	var resolution=global_var.simulation_precision
	var minVal=deg2rad(0)
	var maxVal=deg2rad(85)
	var val=[minVal,maxVal]
	var mpoint=(val[0]+val[1])*0.5
	var shock_angle=0
	#var iterations=0


	if deflection_angle<_plot_curve(m).max()*0.93:
		while abs(_Equation__flowDeflection_shockAngle(mpoint,m)-setpoint)>resolution:
	
			#iterations+=1
			mpoint=(val[0]+val[1])*0.5
			if _Equation__flowDeflection_shockAngle(mpoint,m)>setpoint:
			    val[1]=mpoint
			if _Equation__flowDeflection_shockAngle(mpoint,m)<setpoint:
			    val[0]=mpoint
	
		shock_angle=(val[0]+val[1])*0.5
		global_var.list_weak_shock_angle[index]=shock_angle
	else:
		global_var.error_large_def_angle=true
		print("Error! Deflection (weak shock) angle too large for the given flow condtions (try decreasing aerofoil thickness and lowering speed).")
		
		
	return shock_angle






func _oblique_shock(ii):
	var state=null
	var m=0

	if ii==0:
		m=global_var.m1
	if ii>0 and global_var.list_position[ii]==global_var.list_position[ii-1]:
		m=global_var.list_m[ii-1]
	if ii>0 and global_var.list_position[ii]!=global_var.list_position[ii-1]:
		m=global_var.m1

	if global_var.list_deflection_angle[ii]<_plot_curve(m).max()*0.93:
		global_var.error_large_def_angle_ob_shock_func=false
		var m2=clamp(_m2(ii,m),0,global_var.m1)
		var p2_p0=_interpolate(_dataset_search(m2,m_dataset,p_p0_dataset)[1],_dataset_search(m2,m_dataset,p_p0_dataset)[2],_dataset_search(m2,m_dataset,p_p0_dataset)[3],_dataset_search(m2,m_dataset,p_p0_dataset)[4],m2)
		var theta2=_interpolate(_dataset_search(m2,m_dataset,theta_dataset)[1],_dataset_search(m2,m_dataset,theta_dataset)[2],_dataset_search(m2,m_dataset,theta_dataset)[3],_dataset_search(m2,m_dataset,theta_dataset)[4],m2)
		var p2_p1=_p_p1(ii,m)

		global_var.list_m[ii]=m2
		global_var.list_p_p0[ii]=p2_p0
		global_var.list_theta[ii]=theta2
		global_var.list_p_p1[ii]=p2_p1
		state=true
		
		
	else:
		global_var.error_large_def_angle_ob_shock_func=true
		print("too large def angle")
		state=false
		
	return state
	#_strong_shock(ii,m)
	
		



func _expansion(ii):
	var state=null
	var m4=0
	var p4_p0=0
	var theta4=0
	var p4_p1=0

	if global_var.list_position[ii]=="below" and ii==0:
		theta4=_interpolate(_dataset_search(global_var.m1,m_dataset,theta_dataset)[1],_dataset_search(global_var.m1,m_dataset,theta_dataset)[2],_dataset_search(global_var.m1,m_dataset,theta_dataset)[3],_dataset_search(global_var.m1,m_dataset,theta_dataset)[4],global_var.m1)+global_var.list_deflection_angle[ii]
		
		if theta4<=theta_dataset.max(): ###safety shunt (prevent program crashing if out of dataset's range
			global_var.error_exceeded_dataset_1=false
			p4_p0=_interpolate(_dataset_search(theta4,theta_dataset,p_p0_dataset)[1],_dataset_search(theta4,theta_dataset,p_p0_dataset)[2],_dataset_search(theta4,theta_dataset,p_p0_dataset)[3],_dataset_search(theta4,theta_dataset,p_p0_dataset)[4],theta4)#0.257 #INTERPOLATE. find value of p3_p0 at for theta3 ##################CARRY ON
			m4=_interpolate(_dataset_search(theta4,theta_dataset,m_dataset)[1],_dataset_search(theta4,theta_dataset,m_dataset)[2],_dataset_search(theta4,theta_dataset,m_dataset)[3],_dataset_search(theta4,theta_dataset,m_dataset)[4],theta4)#1.54 #INTERPOLATE. find value of m3 at for theta3 ##################CARRY ON
			p4_p1=p4_p0/_interpolate(_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[1],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[2],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[3],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[4],global_var.m1)
			#print(ii)
			global_var.list_m[ii]=m4
			global_var.list_p_p1[ii]=p4_p1
			global_var.list_p_p0[ii]=p4_p0
			global_var.list_theta[ii]=theta4
			state=true
		else:
			state=false
			#print("Out of (theta) dataset range! Decrease m1 or alpha value.")




	if global_var.list_position[ii]=="below" and ii>0:
		theta4=global_var.list_theta[ii-1]+global_var.list_deflection_angle[ii] 
		
		if theta4<=theta_dataset.max() and global_var.list_p_p0[ii-1]>0: ###safety shunt (prevent program crashing if out of dataset's range
			global_var.error_exceeded_dataset_2=false
			m4=_interpolate(_dataset_search(theta4,theta_dataset,m_dataset)[1],_dataset_search(theta4,theta_dataset,m_dataset)[2],_dataset_search(theta4,theta_dataset,m_dataset)[3],_dataset_search(theta4,theta_dataset,m_dataset)[4],theta4)#1.44#_interpolate(_dataset_search(theta4,theta_dataset,p_p0_dataset)[1],_dataset_search(theta4,theta_dataset,p_p0_dataset)[2],_dataset_search(theta4,theta_dataset,p_p0_dataset)[3],_dataset_search(theta4,theta_dataset,p_p0_dataset)[4],theta4)*10 #1.44 # INTERPOLATE for a value of theta4		
			p4_p0=_interpolate(_dataset_search(theta4,theta_dataset,p_p0_dataset)[1],_dataset_search(theta4,theta_dataset,p_p0_dataset)[2],_dataset_search(theta4,theta_dataset,p_p0_dataset)[3],_dataset_search(theta4,theta_dataset,p_p0_dataset)[4],theta4)   #0.2969 # INTERPOLATE for a value of theta4
			p4_p1=(p4_p0/global_var.list_p_p0[ii-1])*global_var.list_p_p1[ii-1]
			global_var.list_m[ii]=m4
			global_var.list_p_p1[ii]=p4_p1
			global_var.list_p_p0[ii]=p4_p0
			global_var.list_theta[ii]=theta4
			state=true
		else:
			state=false
			#print("Out of (theta) dataset range! Decrease m1 or alpha value.")



	if global_var.list_position[ii]=="above" and global_var.list_position[ii-1]=="below":
		theta4=_interpolate(_dataset_search(global_var.m1,m_dataset,theta_dataset)[1],_dataset_search(global_var.m1,m_dataset,theta_dataset)[2],_dataset_search(global_var.m1,m_dataset,theta_dataset)[3],_dataset_search(global_var.m1,m_dataset,theta_dataset)[4],global_var.m1)+global_var.list_deflection_angle[ii]
		
		if theta4<=theta_dataset.max(): ###safety shunt (prevent program crashing if out of dataset's range
			global_var.error_exceeded_dataset_3=false
			p4_p0=_interpolate(_dataset_search(theta4,theta_dataset,p_p0_dataset)[1],_dataset_search(theta4,theta_dataset,p_p0_dataset)[2],_dataset_search(theta4,theta_dataset,p_p0_dataset)[3],_dataset_search(theta4,theta_dataset,p_p0_dataset)[4],theta4)#0.257 #INTERPOLATE. find value of p3_p0 at for theta3 ##################CARRY ON
			m4=_interpolate(_dataset_search(theta4,theta_dataset,m_dataset)[1],_dataset_search(theta4,theta_dataset,m_dataset)[2],_dataset_search(theta4,theta_dataset,m_dataset)[3],_dataset_search(theta4,theta_dataset,m_dataset)[4],theta4)#1.54 #INTERPOLATE. find value of m3 at for theta3 ##################CARRY ON
			p4_p1=p4_p0/_interpolate(_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[1],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[2],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[3],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[4],global_var.m1)
			global_var.list_m[ii]=m4
			global_var.list_p_p1[ii]=p4_p1
			global_var.list_p_p0[ii]=p4_p0
			global_var.list_theta[ii]=theta4
			state=true
		else:
			state=false
			global_var.error_exceeded_dataset_3=true
			#print("Out of (theta) dataset range! Decrease m1 or alpha value.")




	if global_var.list_position[ii]=="above" and global_var.list_position[ii-1]=="above":
		theta4=global_var.list_theta[ii-1]+global_var.list_deflection_angle[ii]
		
		if theta4<=theta_dataset.max(): ###safety shunt (prevent program crashing if out of dataset's range
			global_var.error_exceeded_dataset_4=false
			p4_p0=_interpolate(_dataset_search(theta4,theta_dataset,p_p0_dataset)[1],_dataset_search(theta4,theta_dataset,p_p0_dataset)[2],_dataset_search(theta4,theta_dataset,p_p0_dataset)[3],_dataset_search(theta4,theta_dataset,p_p0_dataset)[4],theta4)#0.257 #INTERPOLATE. find value of p3_p0 at for theta3 ##################CARRY ON
			m4=_interpolate(_dataset_search(theta4,theta_dataset,m_dataset)[1],_dataset_search(theta4,theta_dataset,m_dataset)[2],_dataset_search(theta4,theta_dataset,m_dataset)[3],_dataset_search(theta4,theta_dataset,m_dataset)[4],theta4)#1.54 #INTERPOLATE. find value of m3 at for theta3 ##################CARRY ON
			p4_p1=p4_p0/_interpolate(_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[1],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[2],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[3],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[4],global_var.m1)
			global_var.list_m[ii]=m4
			global_var.list_p_p1[ii]=p4_p1
			global_var.list_p_p0[ii]=p4_p0
			global_var.list_theta[ii]=theta4
			state=true
		else:
			state=false
			#print("Out of (theta) dataset range! Decrease m1 or alpha value.")

	return state



func _nothing(ii):

	if ii==0: # bottom STARTING plate 
		global_var.list_m[ii]=global_var.m1
		global_var.list_p_p1[ii]=1
		global_var.list_p_p0[ii]=_interpolate(_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[1],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[2],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[3],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[4],global_var.m1)
		global_var.list_theta[ii]=_interpolate(_dataset_search(global_var.m1,m_dataset,theta_dataset)[1],_dataset_search(global_var.m1,m_dataset,theta_dataset)[2],_dataset_search(global_var.m1,m_dataset,theta_dataset)[3],_dataset_search(global_var.m1,m_dataset,theta_dataset)[4],global_var.m1)

	if ii>0 and global_var.list_position[ii]==global_var.list_position[ii-1]: # in between plates (top or bottom)
		global_var.list_m[ii]=global_var.list_m[ii-1]
		global_var.list_p_p1[ii]=global_var.list_p_p1[ii-1]
		global_var.list_p_p0[ii]=global_var.list_p_p0[ii-1]
		global_var.list_theta[ii]=global_var.list_theta[ii-1]

	if ii>0 and global_var.list_position[ii]!=global_var.list_position[ii-1]: # top STARTING plates
		global_var.list_m[ii]=global_var.m1
		global_var.list_p_p1[ii]=1
		global_var.list_p_p0[ii]=_interpolate(_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[1],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[2],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[3],_dataset_search(global_var.m1,m_dataset,p_p0_dataset)[4],global_var.m1)
		global_var.list_theta[ii]=_interpolate(_dataset_search(global_var.m1,m_dataset,theta_dataset)[1],_dataset_search(global_var.m1,m_dataset,theta_dataset)[2],_dataset_search(global_var.m1,m_dataset,theta_dataset)[3],_dataset_search(global_var.m1,m_dataset,theta_dataset)[4],global_var.m1)




func _cn():
	global_var.cn_pressures.clear()
	var summed_pressures=0
	var cn=0

	for i in range(len(global_var.list_p_p1)):
		if global_var.list_position[i]=="below":
			if i==0:
				global_var.cn_pressures.append(global_var.list_p_p1[i])
			else:
				if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)==0:
					global_var.cn_pressures.append(0)
					#print("cn",i)
				else:
					global_var.cn_pressures.append(global_var.list_p_p1[i])
					pass
					
					
		if global_var.list_position[i]=="above":
			if global_var.list_position[i]!=global_var.list_position[i-1]:
				global_var.cn_pressures.append(-global_var.list_p_p1[i])
			else:
				if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)==0:
					global_var.cn_pressures.append(0)
					#print("cn",i)
				else:
					global_var.cn_pressures.append(-global_var.list_p_p1[i])

	for i in range (len(global_var.list_p_p1)):
		summed_pressures+=global_var.cn_pressures[i]

	cn=1/(global_var.gamma*pow(global_var.m1,2)) *summed_pressures
	return cn



func _ca_PRESSURES(): # now fixed
	####used to populate the 'ca_pressures' list with +ve or -ve signs (which will then be used for ca calc#####

	global_var.ca_pressures.clear() #clear the list

	for i in range (len(global_var.list_p_p1)):

		if global_var.list_position[i]=="below":
			if i==0:
				if sign(_plate_gradient(i))==-1:
					global_var.ca_pressures.append(1)
				if sign(_plate_gradient(i))==1:
					global_var.ca_pressures.append(-1)
				if stepify(_plate_gradient(i),0.0001)==0:
					global_var.ca_pressures.append(1)
			else:
				if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)==0:
					global_var.ca_pressures.append(0)
				else:
					if sign(_plate_gradient(i))==-1:
						global_var.ca_pressures.append(1)
					if sign(_plate_gradient(i))==1:
						global_var.ca_pressures.append(-1)
					if stepify(_plate_gradient(i),0.0001)==0:
						global_var.ca_pressures.append(1)

		if global_var.list_position[i]=="above":
			if global_var.list_position[i]!=global_var.list_position[i-1]:
				if sign(_plate_gradient(i))==-1:
					global_var.ca_pressures.append(-1)
				if sign(_plate_gradient(i))==1:
					global_var.ca_pressures.append(1)
				if stepify(_plate_gradient(i),0.0001)==0:
					global_var.ca_pressures.append(-1)
			
			else:
				if stepify(_plate_gradient(i)-_plate_gradient(i-1),0.0001)==0:
					global_var.ca_pressures.append(0)
						
				else:
					if sign(_plate_gradient(i))==-1:
						global_var.ca_pressures.append(-1)
					if sign(_plate_gradient(i))==1:
						global_var.ca_pressures.append(1)
					if stepify(_plate_gradient(i),0.0001)==0:
						global_var.ca_pressures.append(-1)
				
	#print(global_var.ca_pressures)



func _area_t_c():#done
	var maxY_point_bottom=0
	var maxY_point_top=0
	var yDiff=[]
	var xCoords=[]
	var t=0
	var c=0

	######## t###########
	for i in range (len(global_var.list_point_coords)):
		var diff=global_var.list_point_coords[i].y
		yDiff.append(diff)

	yDiff.sort()
	t=abs(yDiff.back()-yDiff.front())
	global_var.t=t

	######## c###########

	for i in range (len(global_var.list_point_coords)): # you could replace with 'xCoords=global_var.list_point_coords.duplicate()'
		xCoords.append(global_var.list_point_coords[i].x) 

	xCoords.sort()

	c=abs(xCoords.back()-xCoords.front())
	global_var.c=c

	global_var.t_c=t/c
	return t/c



func _ca():
	var summed_pressures=0
	var ca=0
	
	for i in range (len(global_var.list_p_p1)):
		summed_pressures+=global_var.ca_pressures[i]*global_var.list_p_p1[i]
		
	ca=global_var.t_c*1/(global_var.gamma*pow(global_var.m1,2)) *summed_pressures
	
	return ca





func _cL():

	var cL=cos(pivot.global_rotation)*_cn() - sin(pivot.global_rotation)*_ca()
	cL_coeff_lift=cL
	global_var.cL=cL
	return cL






func _cD():

	var cD=sin(pivot.global_rotation)*_cn() + cos(pivot.global_rotation)*_ca()
	cD_coeff_drag=cD
	global_var.cD=cD
	return cD
















#########################################################################################################
##################################################INITIALISE##############################################
#########################################################################################################

func _ready():
	OS.center_window()
	_centre_pivot()
	line2d_bottom.set_width(global_var.aerofoil_outline_thickness)
	

#########################################################################################################
##################################################MAIN LOOP##############################################
#########################################################################################################
	
func _on_alpha_slider_value_changed(value):#current
	
	
	
###clean the lists and re-initialise them (to avoid values from previous updates afftecing the next update#######################################################
	_clear_lists()
	
	###rotate the plate by the specified amount ('alpha')#######################################################
	pivot.global_rotation_degrees=value
	
	###update the vectors, coordinates and mpoints of the lines after rotation#######################################################	
	_update_coords_vectors_midpoints()
	
	
	###populate angular and vector lists#######################################################	
	
	_calculate_GlobalAngles()
	
	for i in range (len(global_var.list_vector)):

#		#var vec=(line2d_bottom.get_point_position(4)-line2d_bottom.get_point_position(3)).normalized()
#		#print(rad2deg(pivot.global_transform.y.normalized().dot(vec)))
#		global_var.list_LocalAngles[i]=acos(global_var.list_vector[i].dot(chord_vec2))
#		global_var.list_GlobalAngles[i]=acos(global_var.list_vector[i].dot(horizontal_vector))
		
		###find whether expansion or contraction#######################################################		
		_define_expansion_contraction(i)
		
		###calculate deflection angles#######################################################		
		_deflection_angles(i)

	#var vec=(line2d_bottom.get_point_position(1)-line2d_bottom.get_point_position(0)).normalized()
	#print(rad2deg(pivot.global_transform.y.normalized().dot(vec)))
	#apply _oblique_shock() or _expansion based on whether plate is contraction or expansion#######################################################		
	for ii in range(len(global_var.list_vector)):
		
		if global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==true:
			_oblique_shock(ii)
			
			
		elif global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==false:
			print("oblique break, _on_alpha_slider_value_changed")
			break
			
			
			
			
			
		if global_var.list_strings[ii]=="expansion" and _expansion(ii)==true:
			_expansion(ii)
		elif global_var.list_strings[ii]=="expansion" and _expansion(ii)==false:
			print("expansion break, _on_alpha_slider_value_changed")
			#global_var.list_p_p1.clear()
			#global_var.list_m.clear()
			break
			
			
		if global_var.list_strings[ii]=="nothing":
			_nothing(ii)
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
	for i in 1:
		if _oblique_shock_END_EDGE("top")==true:
			_oblique_shock_END_EDGE("top")
		else:
			break
	
			
		var gradi=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
		if sign(gradi)==1: # to prevent exp fan showing if tehre is an oblique shock line
			if _oblique_shock_END_EDGE("bottom")==true:
				_oblique_shock_END_EDGE("bottom")
			else:
				break
	
	print(global_var.p2_p1_END_EDGE_TOP, "   ",global_var.p2_p1_END_EDGE_BOTTOM)
	#print(global_var.list_p_p1, "   ",global_var.list_m)
	
	
	
	
	
	########Calculate lift coefficient and drag coefficient###################
			
	_cL()
	
	_cD()
		

	#print(global_var.list_p_p1)
	#print(global_var.list_strings)
	#print(global_var.m2_END_EDGE_BOTTOM)
	#print(global_var.list_p_p1,"  ",global_var.list_weak_shock_angle)



func _calculate_LocalAngles():
	global_var.list_LocalAngles.clear()
	for i in range (line2d_bottom.get_point_count()-1):
		var plate_vec=(line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-line2d_bottom.to_global(line2d_bottom.get_point_position(i))).normalized()
		var pivot_dir_vec=pivot.global_transform.y.normalized()
		var angle=pivot_dir_vec.dot(plate_vec)
		global_var.list_LocalAngles.append(abs(angle))
	#print(global_var.list_LocalAngles)

func _calculate_GlobalAngles():
	global_var.list_GlobalAngles.clear()
	for i in range (line2d_bottom.get_point_count()-1):
		var plate_vec=(line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-line2d_bottom.to_global(line2d_bottom.get_point_position(i))).normalized()
		var dir_vec=Vector2(0,1)
		var angle=dir_vec.dot(plate_vec)
		
		global_var.list_GlobalAngles.append(abs(angle))
	#print(global_var.list_GlobalAngles)
	
	
	
	
func _shift_pivot_mp():
	var index=0
	var point_count=line2d_bottom.get_point_count()
	
	for i in range(line2d_bottom.get_point_count()):# find index at which bottom plate changes to top
		if i<line2d_bottom.get_point_count()-1:
			if line2d_bottom.to_global(line2d_bottom.get_point_position(i+1)).x-line2d_bottom.to_global(line2d_bottom.get_point_position(i)).x<0:
				index=i
				#print(i,"index")
				break
				
				
				
				
	var chord_midpoint=(line2d_bottom.to_global(line2d_bottom.get_point_position(0))+line2d_bottom.to_global(line2d_bottom.get_point_position(index)))*0.5
	
	var diff=pivot.global_transform.origin-chord_midpoint
		
	pivot.global_transform.origin=chord_midpoint
	
	for i in range (line2d_bottom.get_point_count()): #move lines
		var pos=line2d_bottom.get_point_position(i)+diff
		line2d_bottom.set_point_position(i,pos)

	
	
	for i in line2d_bottom.get_child_count():#move draggable nodes
		line2d_bottom.get_child(i).queue_free()
		#pivot.get_child(i).rect_global_position=pivot.to_global(line2d_bottom.get_point_position(i-1))-pivot.get_child(i).rect_size*0.5
		
	for i in (line2d_bottom.get_point_count()-1):#move draggable nodes
		_add_collision_node(line2d_bottom.to_global(line2d_bottom.get_point_position(i)))
	
	
func _on_finish_button_pressed():
	if get_node_or_null("label_with_timer_Sketch_Aerofoil"): #delete the text in the top left corner
		get_node("label_with_timer_Sketch_Aerofoil").queue_free()
	
	
	if line2d_bottom.get_point_count()<4: #error message if few nodes
<<<<<<< HEAD
		var error_msg_few_node=label.instance()
		error_log_message_box.add_child(error_msg_few_node)
		error_msg_few_node.text="""#Error! Too few nodes. Add more 
		nodes and try again.#"""
#		error_msg_few_node.rect_size.x*=3
#		error_msg_few_node.rect_global_position=alpha_slider.rect_global_position-Vector2(0,10)
		error_msg_few_node.self_modulate=ColorN("orangered",1.0)
		error_log.show()
=======
		var error_msg_few_node=label_with_timer.instance()
		add_child(error_msg_few_node)
		error_msg_few_node.text="Error! Too few nodes. Add more nodes and try again."
		error_msg_few_node.rect_size.x*=3
		error_msg_few_node.rect_global_position=alpha_slider.rect_global_position-Vector2(0,10)
		error_msg_few_node.self_modulate=ColorN("orangered",1.0)
>>>>>>> e0b9a79e02a3eff675aea345f23db5b087d0349e
	
	
	
	if _check_gradients()==true:# checks if grads are very steep or not
		get_node("sketch_aerofoil_mode").queue_free() #delete the script which allows you to draw the aerofoil
		
		### sets 'line_mode' to 1 (to prevent any adding of further points)
		global_var.line_mode=1
		
		
		###adds last point (to close loop)
		var initial_point_coord=line2d_bottom.get_point_position(0)
		line2d_bottom.add_point(initial_point_coord) 
			
		
		edit_button.disabled=false
		advanced_button.disabled=false
		generate_3d_mesh_button.disabled=false
		checkbox_oblique_shock_lines.pressed=true
		checkbox_expansion_fans.pressed=true
		m_slider.show()
		alpha_slider.show()
		gamma_slider.show()
		save_button.show()
		finish_button.queue_free()
		undo_button.queue_free()
		
		
		_clear_lists()
		_refresh_lists()
		
		_remove_duplicate_entries(line2d_bottom)
		
		_shift_pivot_mp()
		
		_centre_pivot()
		
		line2d_bottom.global_rotation=_clear_AoA()
		#global_var.alpha_offset=_clear_AoA()
		
		_initialise_lists() #CALLED ONCE
		
		###find whether top or bottom side##########################################################################
		_top_or_bottom()#CALLED ONCE
		
		###populate ca_pressures sign list#######################################	
		_ca_PRESSURES()#CALLED ONCE (assumption)
		
		###calc area ratio (t/c)###################################	
		_area_t_c()#CALLED ONCE
		
		global_var.point_count_before_edit=line2d_bottom.get_point_count()
		_store_point_coord_before_edit()
		
		_clear_lists()
		
		_find_bow_shock()
		
		#_MAIN_UPDATE(0)
	
	
	elif _check_gradients()==false:
		print("steep gradient")
		_clear_lists()
		_refresh_lists()
	
	
	
	
func _geometry_edited_checker():
	"""
	if index is NOT the same as global_var.index_bottom_top_plate (i.e. nodes deleted/ moved/added), SHIFT MIDPOINT, shift_pivot_midpoint==true
	if edge nodes are NOT the same as global_var.list_GlobalPointCoords, CLEAR AOA, clear_AoA==true
	
	"""
	
	
	var index=0
	var point_count=line2d_bottom.get_point_count()
	var shift_pivot_midpoint=false
	var clear_AoA=false
	###index checker###

	for i in range(line2d_bottom.get_point_count()):# find index at which bottom plate changes to top
		if i<line2d_bottom.get_point_count()-1:
			if line2d_bottom.get_point_position(i+1).x-line2d_bottom.get_point_position(i).x<0:
				index=i
				#print(i)
				break

	if index!=global_var.index_bottom_top_plate:
		shift_pivot_midpoint=true



	###edge nodes coord checker###
	
	if line2d_bottom.to_global(line2d_bottom.get_point_position(0))!=global_var.list_GlobalPointCoords[0] or line2d_bottom.to_global(line2d_bottom.get_point_position(index))!=global_var.list_GlobalPointCoords[global_var.index_bottom_top_plate]:
		clear_AoA=true
		pass
	
	return[shift_pivot_midpoint,clear_AoA]
	
	
	
	
func _on_button_edit_toggled(button_pressed):
	
#	if _check_gradients()==true:# checks if grads are very steep or not
		
	if button_pressed==true:
		pivot.global_rotation_degrees=0

	if button_pressed==false:
		
		if  _geometry_edited_checker()[1]==true:
			_shift_pivot_mp()
	
			_centre_pivot()
			#print("piv")
			#print("rot")
			line2d_bottom.rotate(_clear_AoA())
			


		_clear_lists()
		
		_refresh_lists()

		_remove_duplicate_entries(line2d_bottom)




		_initialise_lists() #CALLED ONCE
		###find whether top or bottom side##########################################################################
		_top_or_bottom()#CALLED ONCE

		###populate ca_pressures sign list#######################################	
		_ca_PRESSURES()#CALLED ONCE (assumption)

		###calc area ratio (t/c)###################################	
		_area_t_c()#CALLED ONCE

#		global_var.point_count_before_edit=line2d_bottom.get_point_count()
#		_store_point_coord_before_edit()

		_clear_lists()

		_find_bow_shock()

		#pivot.global_rotation+=deg2rad(alpha_slider.value)
		#global_var.alpha_offset=pivot.global_rotation
		#global_var.alpha_offset=_clear_AoA()
		pivot.global_rotation_degrees=alpha_slider.value
		
		#print(global_var.alpha_offset)



	pass












func _store_point_coord_before_edit():
	global_var.point_coord_before_edit.clear()
	
	for i in range(line2d_bottom.get_point_count()):
		global_var.point_coord_before_edit.append(line2d_bottom.get_point_position(i))






	
func _remove_duplicate_entries(line2d):
	for i in range (line2d.get_point_count()):
		for i in range (line2d.get_point_count()):
			if i<line2d.get_point_count()-1:
				if line2d.get_point_position(i).x==line2d.get_point_position(i+1).x and line2d.get_point_position(i).y==line2d.get_point_position(i+1).y:
					line2d.remove_point(i+1)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
#func _display_errors():
#
#	if global_var.error_exceeded_dataset==true:
#		get_node("error_exceeded_dataset").show()
#	if global_var.error_exceeded_dataset==false:
#		get_node("error_exceeded_dataset").hide()
#
#
#	if global_var.error_large_def_angle==true:
#		get_node("error_large_deflection_angle").show()
#	if global_var.error_large_def_angle==false:
#		get_node("error_large_deflection_angle").hide()



	
	
func _add_collision_node(coord):
	#if global_var.finish_button_hover==false:
	var preload_collision_node_instance=preload_collison_node.instance()
	line2d_bottom.add_child(preload_collision_node_instance)
	preload_collision_node_instance.rect_global_position=coord-preload_collision_node_instance.rect_size*0.5
	

















#func _on_chord_slider_value_changed(value): DEPRECATED
#	if global_var.edit_mode==true:
#		if global_var.alpha_radians==0:
#			##starting and end points##
#			line2d_bottom.set_point_position(0,global_var.list_point_coords[0]-line2d_bottom.global_transform.origin-Vector2(value,0)*4)
#			line2d_bottom.set_point_position(line2d_bottom.get_point_count()-1,global_var.list_point_coords[0]-line2d_bottom.global_transform.origin-Vector2(value,0)*4)
#			pivot.get_child(1).rect_global_position=line2d_bottom.get_point_position(0)+line2d_bottom.global_transform.origin-Vector2(pivot.get_child(1).rect_size.x/2,pivot.get_child(1).rect_size.y/2)
#
#			##index point###
#
#			line2d_bottom.set_point_position(global_var.index_bottom_top_plate,global_var.list_point_coords[global_var.index_bottom_top_plate]-line2d_bottom.global_transform.origin+Vector2(value,0)*4)
#			pivot.get_child(global_var.index_bottom_top_plate+1).rect_global_position=line2d_bottom.get_point_position(global_var.index_bottom_top_plate)+line2d_bottom.global_transform.origin-Vector2(pivot.get_child(global_var.index_bottom_top_plate+1).rect_size.x/2,pivot.get_child(global_var.index_bottom_top_plate+1).rect_size.y/2)
#

	


#func _on_thickness_slider_value_changed(value): DEPRECATED
#	var point_count=line2d_bottom.get_point_count()
#	var index=global_var.index_bottom_top_plate
#	if global_var.edit_mode==true:
#		if global_var.alpha_radians==0:
#			for i in range(line2d_bottom.get_point_count()):
#				if i<global_var.index_bottom_top_plate and i!=0:
#					var radius=clamp(line2d_bottom.get_point_position(i).y-pivot.global_transform.origin.y,0,100) ########CHANGE PIVOT TO CENTER OF ORIGIN###
#					line2d_bottom.set_point_position(i,global_var.list_point_coords[i]-line2d_bottom.global_transform.origin+Vector2(0,value)*radius*0.005)
#					pivot.get_child(i+1).rect_global_position=line2d_bottom.get_point_position(i)+line2d_bottom.global_transform.origin-Vector2(pivot.get_child(i+1).rect_size.x/2,pivot.get_child(i+1).rect_size.y/2) #update node positions
#
#				elif i>global_var.index_bottom_top_plate+1 and i<line2d_bottom.get_point_count():
#					var radius=pivot.global_transform.origin.y-line2d_bottom.get_point_position(point_count-i+index).y########CHANGE PIVOT TO CENTER OF ORIGIN###
#					line2d_bottom.set_point_position(point_count-i+index,global_var.list_point_coords[i]-line2d_bottom.global_transform.origin-Vector2(0,value)*radius*0.005)########CHANGE PIVOT TO CENTER OF ORIGIN###
#					pivot.get_child(point_count-i+index+1).rect_global_position=line2d_bottom.get_point_position(point_count-i+index)+line2d_bottom.global_transform.origin-Vector2(pivot.get_child(point_count-i+index+1).rect_size.x/2,pivot.get_child(point_count-i+index+1).rect_size.y/2)
#





func _on_aerofoil_library_popup_index_pressed(index):
	
	
	if index==0:
		var list_coords=global_var.wedge_aerofoil_coords
		for i in range (len(list_coords)):
			line2d_bottom.add_point(line2d_bottom.to_local(list_coords[i]))
			if i<len(list_coords)-1:
				_add_collision_node(list_coords[i])
		
		
		
	if index==1:
		var list_coords=global_var.half_angle_wedge
		for i in range (len(list_coords)):
			line2d_bottom.add_point(line2d_bottom.to_local(list_coords[i]*300))
			if i<len(list_coords)-1:
				_add_collision_node(list_coords[i])
		
		
	polygon2d_initial_occluder.queue_free()
	finish_button.queue_free()
	aerofoil_choice_container.queue_free()
		
	#polygon2d_initial_occluder.queue_free()
		
	undo_button.disabled=true
	edit_button.disabled=false
	advanced_button.disabled=false
	generate_3d_mesh_button.disabled=false
	checkbox_oblique_shock_lines.pressed=true
	checkbox_expansion_fans.pressed=true
	m_slider.show()
	alpha_slider.show()
	gamma_slider.show()
	save_button.show()
		
		
	_shift_pivot_mp()
	
	_centre_pivot()
	
	line2d_bottom.rotate(_clear_AoA())
	
	_clear_lists()
	
	_refresh_lists()
	
	_initialise_lists() #CALLED ONCE
	
	###find whether top or bottom side##########################################################################
	_top_or_bottom()#CALLED ONCE

	###populate ca_pressures sign list#######################################	
	_ca_PRESSURES()#CALLED ONCE (assumption)
	#_update_coords_vectors_midpoints()

	###calc area ratio (t/c)###################################	
	_area_t_c()#CALLED ONCE
	#print(line2d_bottom.get_point_position(0),global_var.list_point_coords[0])
	
	
	_find_bow_shock()
	
	















		

#		for i in range(line2d_bottom.get_point_count()):
#			print(pivot.to_global(line2d_bottom.get_point_position(i)))
#
		
		
		
		
#	else:
#		var rich_text_instance=rich_text.instance()
#		add_child(rich_text_instance)
#		rich_text_instance.rect_global_position=pivot.global_transform.origin
#		rich_text_instance.text="There are no files to load."







func _clear_AoA():
	
	
	var index=0
	var point_count=line2d_bottom.get_point_count()
		
	for i in range(line2d_bottom.get_point_count()):# find index at which bottom plate changes to top
		if i<line2d_bottom.get_point_count()-1:
			if line2d_bottom.to_global(line2d_bottom.get_point_position(i+1)).x-line2d_bottom.to_global(line2d_bottom.get_point_position(i)).x<0:
				index=i
				#print(i)
				break
	
	var sign_rot=1
	var dir_vec=Vector2()
	var angle=0
	
	
	if line2d_bottom.to_global(line2d_bottom.get_point_position(0)).y-line2d_bottom.to_global(line2d_bottom.get_point_position(index)).y>0:
		sign_rot=1
	if line2d_bottom.to_global(line2d_bottom.get_point_position(0)).y-line2d_bottom.to_global(line2d_bottom.get_point_position(index)).y<0:
		sign_rot=-1
		
	dir_vec=(line2d_bottom.to_global(line2d_bottom.get_point_position(index))-line2d_bottom.to_global(line2d_bottom.get_point_position(0))).normalized()
	
	angle=acos(dir_vec.dot(horizontal_vector))*sign_rot
	
	#global_var.alpha_offset=angle
	
	return angle







func _check_gradients():
	
	"""
	this function checks whether a gradient is  very large (>100) or not.
	If it is, it returns false, ortherwise it returns true
	"""
	
	_initialise_lists()
	
	var state=null
	
	for i in range(line2d_bottom.get_point_count()-1):
		
		if abs(_plate_gradient(i))>1000000000:
			print("break")
			state=false
			global_var.index_start_line_error=i
			add_child(error_line_highlight.instance())
			print(i,_plate_gradient(i))
			break
			
		else:
			state=true
			
		
	return state
		
	
			
		


#
#func _on_finish_button_mouse_entered(): #deprecated
#	global_var.finish_button_hover=true
#	pass # Replace with function body.
#
#
#func _on_finish_button_mouse_exited():#deprecated
#	global_var.finish_button_hover=false
#	pass # Replace with function body.




func _check():
	var state=null
	var reason=null
	
	for ii in range(len(global_var.list_vector)):

		if global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==true:
			_oblique_shock(ii)
			state=true
		elif global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==false:
			print("oblique break, _check")
			state=false
			reason="oblique"
			break


		if global_var.list_strings[ii]=="expansion" and _expansion(ii)==true:
			_expansion(ii)
			state=true
		elif global_var.list_strings[ii]=="expansion" and _expansion(ii)==false:
			print("expansion break, _check")
			state=false
			reason="expansion"
			break

		if global_var.list_strings[ii]=="nothing":
			_nothing(ii)
			
	if state==true:
		for i in 1:
			if _oblique_shock_END_EDGE("top")==true:
				_oblique_shock_END_EDGE("top")
				state=true
			else:
				print("end top edge break")
				state=false
				break
		
				
			var gradi=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
			if sign(gradi)==1: # to prevent exp fan showing if tehre is an oblique shock line
				if _oblique_shock_END_EDGE("bottom")==true:
					_oblique_shock_END_EDGE("bottom")
					state=true
				else:
					print("bottom edge break")
					state=false
					break

	return [state,reason]
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
func _find_bow_shock():
	var number_of_iter=10 # 1000 gives best precision, but very slow
	var precision=1#float(number_of_iter)/float(number_of_iter*float(10))
	var cL_plot_list=[]
	var cD_plot_list=[]
	var cD_div_cL_plot_list=[]
	var cL_div_cD_plot_list=[]
	var alpha_radians_plot_list=[]
	var count=0
	var first_break=null
	var index_at_break=0
	var global_rot_before_break=0
	
	
	global_var.cL_plot_list.clear()
	global_var.cD_plot_list.clear()
	global_var.cD_div_cL_plot_list.clear()
	global_var.cL_div_cD_plot_list.clear()
	
	for i in range(number_of_iter):
		_clear_lists()
		
		#pivot.global_rotation_degrees=(float(i)/(precision*0.1))
		pivot.rotate(deg2rad(precision))
		count+=precision
		_update_coords_vectors_midpoints()
		
		
		###populate angular and vector lists#######################################################	
		for ii in range (len(global_var.list_vector)):
			###find whether expansion or contraction#####################################################################		
			_define_expansion_contraction(ii)
			
			###calculate deflection angles#####################################################################		
			_deflection_angles(ii)
			
			
		### check whether bow occurs or not

		#_check()
				
				
		if _check()[0]==true:
			alpha_slider.max_value=10
			global_var.bow_shock_angle=10
		elif _check()[0]==false:
			print("broken",count)
			global_var.bow_shock_angle=float(count)
			alpha_slider.max_value=count-1
			first_break=true
			index_at_break=i
			break
			
			
			
		#global_var.alpha_radians=pivot.global_rotation
		
		alpha_radians_plot_list.append(pivot.global_rotation)
		########Calculate lift coefficient and drag coefficient###################
				
		
		
		_cL()
		cL_plot_list.append(global_var.cL)
		
		_cD()
		cD_plot_list.append(global_var.cD)
		
		
		if global_var.cL==0:
			cD_div_cL_plot_list.append(global_var.cD/0.000001) # to prevent division by 0
		else:
			cD_div_cL_plot_list.append(global_var.cD/global_var.cL)
		
		if global_var.cD==0:
			cL_div_cD_plot_list.append(global_var.cL/0.000001) # to prevent division by 0
		else:
			cL_div_cD_plot_list.append(global_var.cL/global_var.cD)
		
		
		
		
		
		
		
		
#
	if first_break==true:
		pivot.rotate(deg2rad(-1))
		for i in range(number_of_iter):
			_clear_lists()

			#pivot.global_rotation_degrees=(float(i)/(precision*0.1))
			pivot.rotate(deg2rad(0.1))
			count+=0.1

			_update_coords_vectors_midpoints()


			###populate angular and vector lists#######################################################	
			for ii in range (len(global_var.list_vector)):
				###find whether expansion or contraction#####################################################################		
				_define_expansion_contraction(ii)

				###calculate deflection angles#####################################################################		
				_deflection_angles(ii)


			### check whether bow occurs or not
			#_check()

			if _check()[0]==true:
				#print(float(i)/100)
				alpha_slider.max_value=10
				global_var.bow_shock_angle=10.0
				
				pass

			elif _check()[0]==false:
				#pivot.rotate(deg2rad(float(i)/5))
				print("second break",count-1)
				global_var.bow_shock_angle=float(count-1)
				alpha_slider.max_value=count-1
				_add_bow_shock_message()
				break
				
				
				
				
			#global_var.alpha_radians=pivot.global_rotation
			
			alpha_radians_plot_list.append(pivot.global_rotation)

			_cL()
			cL_plot_list.append(global_var.cL)

			_cD()
			cD_plot_list.append(global_var.cD)


			if global_var.cL==0:
				cD_div_cL_plot_list.append(global_var.cD/0.000001) # to prevent division by 0
			else:
				cD_div_cL_plot_list.append(global_var.cD/global_var.cL)
			
			if global_var.cD==0:
				cL_div_cD_plot_list.append(global_var.cL/0.000001) # to prevent division by 0
			else:
				cL_div_cD_plot_list.append(global_var.cL/global_var.cD)
	
		
	
		if stepify(global_var.bow_shock_angle,0.1)==0.1: # if bow shock occurs
			alpha_slider.hide()
			#m_slider.hide()
			#gamma_slider.hide()
		else:# if bow shock NOT occurs
			alpha_slider.show()
			m_slider.show()
			gamma_slider.show()
		
		
	print(global_var.bow_shock_angle)
	#pivot.global_rotation_degrees=alpha_slider.value
	pivot.global_rotation_degrees=0
	global_var.cL_plot_list=cL_plot_list
	global_var.cD_plot_list=cD_plot_list
	global_var.cD_div_cL_plot_list=cD_div_cL_plot_list
	global_var.cL_div_cD_plot_list=cL_div_cD_plot_list
	global_var.alpha_radians_plot_list=alpha_radians_plot_list
	#print(global_var.alpha_radians_plot_list)
	
	
func _centre_pivot(): # sets pivot to centre of screen
	pivot.global_transform.origin=viewport_vec*0.5








func _on_m_slider_button_button_up():
	var ang=pivot.global_rotation
	
	_clear_lists()
	
	pivot.global_rotation=0
	
	_find_bow_shock()
	
###clean the lists and re-initialise them (to avoid values from previous updates afftecing the next update#######################################################
	pivot.global_rotation=ang

	_clear_lists()

	###update the vectors, coordinates and mpoints of the lines after rotation#######################################################	
	_update_coords_vectors_midpoints()

	###populate angular and vector lists#######################################################	

	_calculate_GlobalAngles()

	for i in range (len(global_var.list_vector)):

		###find whether expansion or contraction#######################################################		
		_define_expansion_contraction(i)

		###calculate deflection angles#######################################################		
		_deflection_angles(i)

	#apply _oblique_shock() or _expansion based on whether plate is contraction or expansion#######################################################		
	for ii in range(len(global_var.list_vector)):

		if global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==true:
			_oblique_shock(ii)
		elif global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==false:
			print("oblique break, _on_alpha_slider_value_changed")
			break



		if global_var.list_strings[ii]=="expansion" and _expansion(ii)==true:
			_expansion(ii)
		elif global_var.list_strings[ii]=="expansion" and _expansion(ii)==false:
			print("expansion break, _on_alpha_slider_value_changed")
			break


		if global_var.list_strings[ii]=="nothing":
			_nothing(ii)








	for i in 1:
		if _oblique_shock_END_EDGE("top")==true:
			_oblique_shock_END_EDGE("top")
		else:
			break


		var gradi=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
		if sign(gradi)==1: # to prevent exp fan showing if tehre is an oblique shock line
			if _oblique_shock_END_EDGE("bottom")==true:
				_oblique_shock_END_EDGE("bottom")
			else:
				break

#		print(global_var.p2_p1_END_EDGE_TOP, "   ",global_var.p2_p1_END_EDGE_BOTTOM)







	########Calculate lift coefficient and drag coefficient###################

	_cL()

	_cD()
		
	global_var.random_graph_point_color=Color(rand_range(0,1),rand_range(0,1),rand_range(0,1))
	
	
	
	
	
	
	
	
	
	
	
	
func _on_gamma_slider_button_button_up():
	var ang=pivot.global_rotation
	
	_clear_lists()
	
	pivot.global_rotation=0
	
	_find_bow_shock()
	
###clean the lists and re-initialise them (to avoid values from previous updates afftecing the next update#######################################################
	pivot.global_rotation=ang
	
	_clear_lists()
	
	###update the vectors, coordinates and mpoints of the lines after rotation#######################################################	
	_update_coords_vectors_midpoints()
	
	###populate angular and vector lists#######################################################	
	
	_calculate_GlobalAngles()
	
	for i in range (len(global_var.list_vector)):

		###find whether expansion or contraction#######################################################		
		_define_expansion_contraction(i)
		
		###calculate deflection angles#######################################################		
		_deflection_angles(i)

	#apply _oblique_shock() or _expansion based on whether plate is contraction or expansion#######################################################		
	for ii in range(len(global_var.list_vector)):
		
		if global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==true:
			_oblique_shock(ii)
		elif global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==false:
			print("oblique break, _on_alpha_slider_value_changed")
			break
			
			
			
		if global_var.list_strings[ii]=="expansion" and _expansion(ii)==true:
			_expansion(ii)
		elif global_var.list_strings[ii]=="expansion" and _expansion(ii)==false:
			print("expansion break, _on_alpha_slider_value_changed")
			break
			
			
		if global_var.list_strings[ii]=="nothing":
			_nothing(ii)
			
			
			
			
			
			
			
			
	for i in 1:
		if _oblique_shock_END_EDGE("top")==true:
			_oblique_shock_END_EDGE("top")
		else:
			break
	
			
		var gradi=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
		if sign(gradi)==1: # to prevent exp fan showing if tehre is an oblique shock line
			if _oblique_shock_END_EDGE("bottom")==true:
				_oblique_shock_END_EDGE("bottom")
			else:
				break
	
#		print(global_var.p2_p1_END_EDGE_TOP, "   ",global_var.p2_p1_END_EDGE_BOTTOM)
			
	
	########Calculate lift coefficient and drag coefficient###################
			
	_cL()
	
	_cD()
<<<<<<< HEAD
=======
		
	
	
	
	
	
	
	
	
	
	
	
	
	
func _on_gamma_slider_button_button_up():
	var ang=pivot.global_rotation
	
	_clear_lists()
	
	pivot.global_rotation=0
	
	_find_bow_shock()
	
###clean the lists and re-initialise them (to avoid values from previous updates afftecing the next update#######################################################
	pivot.global_rotation=ang
	
	_clear_lists()
	
	###update the vectors, coordinates and mpoints of the lines after rotation#######################################################	
	_update_coords_vectors_midpoints()
	
	###populate angular and vector lists#######################################################	
	
	_calculate_GlobalAngles()
	
	for i in range (len(global_var.list_vector)):

		###find whether expansion or contraction#######################################################		
		_define_expansion_contraction(i)
		
		###calculate deflection angles#######################################################		
		_deflection_angles(i)

	#apply _oblique_shock() or _expansion based on whether plate is contraction or expansion#######################################################		
	for ii in range(len(global_var.list_vector)):
		
		if global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==true:
			_oblique_shock(ii)
		elif global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==false:
			print("oblique break, _on_alpha_slider_value_changed")
			break
			
			
			
		if global_var.list_strings[ii]=="expansion" and _expansion(ii)==true:
			_expansion(ii)
		elif global_var.list_strings[ii]=="expansion" and _expansion(ii)==false:
			print("expansion break, _on_alpha_slider_value_changed")
			break
			
			
		if global_var.list_strings[ii]=="nothing":
			_nothing(ii)
			
			
			
			
			
			
			
			
	for i in 1:
		if _oblique_shock_END_EDGE("top")==true:
			_oblique_shock_END_EDGE("top")
		else:
			break
	
			
		var gradi=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
		if sign(gradi)==1: # to prevent exp fan showing if tehre is an oblique shock line
			if _oblique_shock_END_EDGE("bottom")==true:
				_oblique_shock_END_EDGE("bottom")
			else:
				break
	
		print(global_var.p2_p1_END_EDGE_TOP, "   ",global_var.p2_p1_END_EDGE_BOTTOM)
			
			
			
			
			
			
	
	########Calculate lift coefficient and drag coefficient###################
			
	_cL()
	
	_cD()
>>>>>>> e0b9a79e02a3eff675aea345f23db5b087d0349e
	pass
	
	
	
	
	

func _add_bow_shock_message(): # adds message when bow shock if formed
	
	
	if global_var.bow_shock_angle+1==1.1:
<<<<<<< HEAD
		var label_error=label.instance()
		label_error.text="""Bow shock forms at AoA of 0 deg.
		Try : (1) reducing the thickness 
		(EDIT -> THICKNESS) of the aerofoil (2)
		Adjusting flow speed and trying again."""
		label_error.self_modulate=ColorN("orangered",1.0)
		error_log_message_box.add_child(label_error)
		error_log.show()
=======
		label.text="Bow shock forms at AoA of 0 deg. Try : (1) reducing the thickness (EDIT -> THICKNESS) of the aerofoil (2) Adjusting flow speed and trying again."
		label.self_modulate=ColorN("orangered",1.0)
		label.get_node("Timer").wait_time=10
	else:
		label.text="Bow shock forms at AoA of : " + str(global_var.bow_shock_angle) + " deg"
		label.get_node("Timer").wait_time=3
>>>>>>> e0b9a79e02a3eff675aea345f23db5b087d0349e
		
	else:
		var lab_timer=label_with_timer.instance()
		lab_timer.text="Bow shock forms at AoA of : " + str(global_var.bow_shock_angle) + " deg"
		lab_timer.get_node("Timer").wait_time=3
		add_child(lab_timer)
		lab_timer.rect_global_position=screen_center+Vector2(-lab_timer.rect_size.x*0.5,200)
		lab_timer.rect_size.x*=2
		
	pass
	
	
	
	
	
	
	
	
	
	
	
func _MAIN_UPDATE():
###clean the lists and re-initialise them (to avoid values from previous updates afftecing the next update)#######################################################
	_clear_lists()
	
	###rotate the plate by the specified amount ('alpha')#######################################################
	
	###update the vectors, coordinates and mpoints of the lines after rotation###########	
	_update_coords_vectors_midpoints()
	
	
	###populate angular and vector lists#######################################################	
	
	_calculate_GlobalAngles()
	
	for i in range (len(global_var.list_vector)):

#		#var vec=(line2d_bottom.get_point_position(4)-line2d_bottom.get_point_position(3)).normalized()
#		#print(rad2deg(pivot.global_transform.y.normalized().dot(vec)))
#		global_var.list_LocalAngles[i]=acos(global_var.list_vector[i].dot(chord_vec2))
#		global_var.list_GlobalAngles[i]=acos(global_var.list_vector[i].dot(horizontal_vector))
		
		###find whether expansion or contraction#####################################################################		
		_define_expansion_contraction(i)
		
		###calculate deflection angles#####################################################################		
		_deflection_angles(i)

	#var vec=(line2d_bottom.get_point_position(1)-line2d_bottom.get_point_position(0)).normalized()
	#print(rad2deg(pivot.global_transform.y.normalized().dot(vec)))
	#apply _oblique_shock() or _expansion based on whether plate is contraction or expansion###########################		
	for ii in range(len(global_var.list_vector)):
		
		if global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==true:
			_oblique_shock(ii)
		elif global_var.list_strings[ii]=="contraction" and _oblique_shock(ii)==false:
			break
			print("oblique break, _on_alpha_slider_value_changed")
			
			
			
		if global_var.list_strings[ii]=="expansion" and _expansion(ii)==true:
			_expansion(ii)
		elif global_var.list_strings[ii]=="expansion" and _expansion(ii)==false:
			print("expansion break, _on_alpha_slider_value_changed")
			#global_var.list_p_p1.clear()
			#global_var.list_m.clear()
			break
			
			
		if global_var.list_strings[ii]=="nothing":
			_nothing(ii)
			
	_cL()
	
	_cD()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

func _on_open_aerofoil_button_pressed():
	var new_file=File.new()
	var dir=Directory.new()
	
	if dir.dir_exists(OS.get_user_data_dir()+"/saved_data_folder"):
		new_file.open(OS.get_user_data_dir()+"/saved_data_folder/"+global_var.saved_files_array[global_var.saved_file_index_selected],File.READ)
		var loaded_coords=new_file.get_var()["coords"]
		
		for i in range(len(loaded_coords)):
			var coord=Vector2(loaded_coords[i][0],loaded_coords[i][1])
			line2d_bottom.add_point(coord)
			if i<len(loaded_coords)-2:
				_add_collision_node(coord)
			
		polygon2d_initial_occluder.queue_free()
		aerofoil_choice_container.queue_free()
		
		global_var.saved_files_array.clear() # clean save dfiles array
		global_var.saved_file_index_selected=0 # reset index to 0
		
		
		#dir.make_dir("res://saved_data_folder")
			
		
		_shift_pivot_mp()
		
		_centre_pivot()
		
		line2d_bottom.rotate(_clear_AoA())
		
		_clear_lists()
		
		_refresh_lists()
		
		
		_initialise_lists() #CALLED ONCE
		
		###find whether top or bottom side##########################################################################
		_top_or_bottom()#CALLED ONCE
	
		###populate ca_pressures sign list#######################################	
		_ca_PRESSURES()#CALLED ONCE (assumption)
		#_update_coords_vectors_midpoints()
	
		###calc area ratio (t/c)###################################	
		_area_t_c()#CALLED ONCE
		#print(line2d_bottom.get_point_position(0),global_var.list_point_coords[0])



		edit_button.disabled=false
		undo_button.disabled=true
		advanced_button.disabled=false
		generate_3d_mesh_button.disabled=false
		checkbox_oblique_shock_lines.pressed=true
		checkbox_expansion_fans.pressed=true
		m_slider.show()
		alpha_slider.show()
		gamma_slider.show()
		save_button.show()
		
		_find_bow_shock()
		
		
	else:
		print("no files to load")
		return
	
		
		
	pass # Replace with function body.









































































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


	beta_array_initial=global_var._linspace(deg2rad(0.01),deg2rad(110),points)
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
	var maxVal=deg2rad(110)
	var val=[minVal,maxVal]
	var mpoint=(val[0]+val[1])*0.5
	var shock_angle=0
	#var iterations=0


	if deflection_angle<_plot_curve_END_EDGE(m).max()*0.8:
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
		
		alpha_slider.max_value=pivot.global_rotation_degrees-0.1
		
		var error_message=label.instance()
		error_log_message_box.add_child(error_message)
		error_message.text="""#Error! Deflection angle out of plot 
		range. Try editing the geometry to 
		reduce steep plate angles.#"""
#		error_message.rect_size.x*=2
#		error_message.rect_global_position=alpha_slider.rect_global_position-Vector2(0,60)
		error_message.self_modulate=ColorN("orangered",1.0)
		error_log.show()
		
		return 0.0
		
	return shock_angle










func _print():
	print(global_var.list_position)
	print(global_var.list_point_coords)
	print(global_var.list_midpoint_pos)
	print(global_var.list_vector)
	print(global_var.list_LocalAngles)
	print(global_var.list_GlobalAngles)
	print(global_var.list_strings)
	print(global_var.list_p_p1)
	print(global_var.list_p_p0)
	print(global_var.list_theta)
	print(global_var.list_deflection_angle)
	print(global_var.list_m)
	print(global_var.list_weak_shock_angle)
	print(global_var.list_strong_shock_angle)
	
	print(global_var.index_bottom_top_plate)


	print(global_var.expansion_angle1)
	print(global_var.expansion_angle2)
	
	print(global_var.cn_pressures)
	print(global_var.ca_pressures)
	
	print(global_var.t_c)
	print(global_var.t)
	print(global_var.c)

	print(global_var.cL)
	print(global_var.cD)


#func _please_wait_message():# currently not in use
#
#	var label_instance=label_with_timer.instance()
#	label_instance.get_node("Timer").wait_time=0.1
#	add_child(label_instance)
#	label_instance.text="Please wait..."
#	label_instance.rect_global_position=viewport_vec*0.5