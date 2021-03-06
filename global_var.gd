#Copyright (c) 2019 Mehdi Msayib#
extends Node


onready var main_scene=preload("res://scenes/Node.tscn")
onready var help_scene=preload("res://scenes/help_scene.tscn")
onready var about_scene=preload("res://scenes/about_scene.tscn")
onready var settings_scene=preload("res://scenes/settings_menu.tscn")

onready var rich_text=preload("res://scenes/rich_text.tscn")
onready var plate_indices_scene=preload("res://scenes/plate_indices_node.tscn")
onready var node_indices_scene=preload("res://scenes/node_indices.tscn")

onready var viewport_vec=get_viewport().size


var m_dataset=[1,	1.02,	1.04,	1.06,	1.08,	1.1,	1.12,	1.14,	1.16,	1.18,	1.2,	1.22,	1.24,	1.26,	1.28,	1.3,	1.32,	1.34,	1.36,	1.38,	1.4,	1.42,	1.44,	1.46,	1.48,	1.5,	1.52,	1.54,	1.56,	1.58,	1.6,	1.62,	1.64,	1.66,	1.68,	1.7,	1.72,	1.74,	1.76,	1.78,	1.8,	1.82,	1.84,	1.86,	1.88,	1.9,	1.92,	1.94,	1.96,	1.98,	2,	2.02,	2.04,	2.06,	2.08,	2.1,	2.12,	2.14,	2.16,	2.18,	2.2,	2.22,	2.24,	2.26,	2.28,	2.3,	2.32,	2.34,	2.36,	2.38,	2.4,	2.42,	2.44,	2.46,	2.48,	2.5,	2.52,	2.54,	2.56,	2.58,	2.6,	2.62,	2.64,	2.66,	2.68,	2.7,	2.72,	2.74,	2.76,	2.78,	2.8,	2.82,	2.84,	2.86,	2.88,	2.9,	2.92,	2.94,	2.96,	2.98,	3,	3.02,	3.04,	3.06,	3.08,	3.1,	3.12,	3.14,	3.16,	3.18,	3.2,	3.22,	3.24,	3.26,	3.28,	3.3,	3.32,	3.34,	3.36,	3.38,	3.4,	3.42,	3.44,	3.46,	3.48,	3.5,	3.52,	3.54,	3.56,	3.58,	3.6,	3.62,	3.64,	3.66,	3.68,	3.7,	3.72,	3.74,	3.76]
var p_p0_dataset=[0.5283,	0.516,	0.5039,	0.4919,	0.48,	0.4684,	0.4568,	0.4455,	0.4343,	0.4232,	0.4124,	0.4017,	0.3912,	0.3809,	0.3708,	0.3609,	0.3512,	0.3417,	0.3323,	0.3232,	0.3142,	0.3055,	0.2969,	0.2886,	0.2804,	0.2724,	0.2646,	0.257,	0.2496,	0.2423,	0.2353,	0.2284,	0.2217,	0.2151,	0.2088,	0.2026,	0.1966,	0.1907,	0.185,	0.1794,	0.174,	0.1688,	0.1637,	0.1587,	0.1539,	0.1492,	0.1447,	0.1403,	0.136,	0.1318,	0.1278,	0.1239,	0.1201,	0.1164,	0.1128,	0.1094,	0.106,	0.1027,	0.0996,	0.0965,	0.0935,	0.0906,	0.0878,	0.0851,	0.0825,	0.08,	0.0775,	0.0751,	0.0728,	0.0706,	0.0684,	0.0663,	0.0643,	0.0623,	0.0604,	0.0585,	0.0567,	0.055,	0.0533,	0.0517,	0.0501,	0.0486,	0.0471,	0.0457,	0.0443,	0.043,	0.0417,	0.0404,	0.0392,	0.038,	0.0368,	0.0357,	0.0347,	0.0336,	0.0326,	0.0317,	0.0307,	0.0298,	0.0289,	0.0281,	0.0272,	0.0264,	0.0256,	0.0249,	0.0242,	0.0234,	0.0228,	0.0221,	0.0215,	0.0208,	0.0202,	0.0196,	0.0191,	0.0185,	0.018,	0.0175,	0.017,	0.0165,	0.016,	0.0156,	0.0151,	0.0147,	0.0143,	0.0139,	0.0135,	0.0131,	0.0127,	0.0124,	0.012,	0.0117,	0.0114,	0.0111,	0.0108,	0.0105,	0.0102,	0.0099,	0.0096,	0.0094,	0.0091]
var theta_dataset=[0, 0.002194, 0.006126, 0.011113, 0.016895, 0.023321, 0.030281, 0.037699, 0.045506, 0.053657, 0.062102, 0.070811, 0.079751, 0.088891, 0.098213, 0.107692, 0.117309, 0.127049, 0.136895, 0.146835, 0.156853, 0.166941, 0.177088, 0.187283, 0.197517, 0.207785, 0.218077, 0.228387, 0.238709, 0.249034, 0.259363, 0.269685, 0.279998, 0.290297, 0.300581, 0.310841, 0.321078, 0.331288, 0.341467, 0.351611, 0.361721, 0.371792, 0.381822, 0.391812, 0.401757, 0.411655, 0.421507, 0.431311, 0.441064, 0.450764, 0.460414, 0.470008, 0.47955, 0.489036, 0.498466, 0.50784, 0.517155, 0.526414, 0.535614, 0.544754, 0.553837, 0.562858, 0.57182, 0.580723, 0.589565, 0.598348, 0.607069, 0.615729, 0.62433, 0.632869, 0.641347, 0.649767, 0.658124, 0.666421, 0.674659, 0.682836, 0.690951, 0.69901, 0.707007, 0.714944, 0.722823, 0.730644, 0.738403, 0.746107, 0.753752, 0.761339, 0.768868, 0.77634, 0.783756, 0.791114, 0.798417, 0.805663, 0.812854, 0.819991, 0.827071, 0.834098, 0.841071, 0.847991, 0.854855, 0.861669, 0.868429, 0.875138, 0.881794, 0.888401, 0.894954, 0.901457, 0.907912, 0.914315, 0.92067, 0.926976, 0.933233, 0.939443, 0.945604, 0.951718, 0.957784, 0.963806, 0.96978, 0.975709, 0.981591, 0.98743, 0.993223, 0.998972, 1.00468, 1.010341, 1.01596, 1.021538, 1.027072, 1.032563, 1.038015, 1.043424, 1.048793, 1.054123, 1.059411, 1.06466, 1.069869, 1.075041, 1.080172, 1.085267, 1.090323]





var m1=2
var gamma=1.4
var alpha_degrees=0
var alpha_radians=0
var simulation_precision=0

var alpha_offset=0 # DEPRECATED

var aerofoil_choice="custom"
var edit_mode=false
#var delete_node=false

#var undo_hover=false #deprecated
var aerofoil_button_hover=false
#var finish_button_hover=false #deprecated
#var edit_button_hover=false
#var add_node_button_hover=false

var node_selected=false


var line_mode=0
var pivot_rotation=0
var list_position=[]
var list_point_coords=[]
var list_GlobalPointCoords=[]
var list_midpoint_pos=[]
var list_vector=[]
var list_LocalAngles=[] # angle relative to chord (i.e. 'half_angle'). Only calculate when a node position is changed, and NOT every frame (as it remains constant)
var list_GlobalAngles=[]# angle relative to horizontal
var list_strings=[]
var list_p_p1=[]
var list_p_p0=[]
var list_theta=[]
var list_deflection_angle=[]
var list_m=[]
var list_weak_shock_angle=[]
var list_strong_shock_angle=[]

var index_bottom_top_plate=0

var expansion_angle1=0
var expansion_angle2=0

var cn_pressures=[]
var ca_pressures=[]

var t_c=0
var t=0
var c=0


var cL=0
var cD=0

var cL_plot_list=[]
var cD_plot_list=[]
var cD_div_cL_plot_list=[]
var cL_div_cD_plot_list=[]

var execute_program=false

var shock_vs_deflection_points=[]

var error_large_def_angle=false
var error_large_def_angle_ob_shock_func=false
var error_exceeded_dataset_1=false
var error_exceeded_dataset_2=false
var error_exceeded_dataset_3=false
var error_exceeded_dataset_4=false

var times_moved_m_slider=0

var shift_midpoint=false

var aerofoil_outline_thickness=5
var aerofoil_outline_colour=Color(0,0.5,0.8)

var wedge_aerofoil_coords=[Vector2(362.000397, 299.999512), Vector2(512.000427, 317.999298), Vector2(610.000366, 297.999176), Vector2(511.000366, 287.999298),Vector2(362.000397, 299.999512)]
#var wing_aerofoil_coords=[Vector2(221.000397, 299.999634), Vector2(371.000427, 340.999451), Vector2(402.000427, 343.99942), Vector2(446.000427, 343.999359), Vector2(501.000427, 339.999268), Vector2(545.000427, 334.999237), Vector2(567.000427, 328.999207), Vector2(591.000427, 321.999176), Vector2(613.000427, 314.999146), Vector2(649.000366, 306.999084), Vector2(686.000366, 304.999054),Vector2(656.000366, 284.999084) , Vector2(635.000366, 281.999115),Vector2(610.000366, 278.999146),Vector2(567.000366, 272.999207),Vector2(498.000366, 267.999268),Vector2(432.000336, 265.999359),Vector2(340.000336, 266.999481),Vector2(287.000336, 268.999542),Vector2(221.000397, 299.999634)]
var half_angle_wedge=[Vector2(0,0),  Vector2( cos(deg2rad(4.75)),sin(deg2rad(4.75))),  Vector2( cos(deg2rad(4.75)),sin(deg2rad(4.75)))+Vector2( cos(deg2rad(4.75)),-sin(deg2rad(4.75))),   Vector2( cos(deg2rad(4.75)),sin(deg2rad(4.75)))+Vector2( cos(deg2rad(4.75)),-sin(deg2rad(4.75)))+Vector2( -cos(deg2rad(4.75)),-sin(deg2rad(4.75))),   Vector2(0,0)]




var save_aerofoil=false
var saved_aerofoil_coords=[]
var saved_aerofoil_point_count=0


#### 3d aerofoil mesh vars######
var aerofoil_3d_mesh_coords=[]
var vertex_vectors=[]
var aerofoil_size=0.03
var aerofoil_height=25
var aerofoil_inset_thickness=0.15



#### line error variables (if gradeint too steep)####
var index_start_line_error=0

var bow_shock_angle=0

var alpha_radians_plot_list=[]

var point_count_before_edit=0

var point_coord_before_edit=[]

var aerofoil_geomtery_changed=true

var random_graph_point_color=Color(1.0,1.0,1.0)



var add_node_mode=false
var delete_node_mode=false
var move_node_mode=false
var chord_length_mode=false
var thickness_mode=false


var weak_shock_END_EDGE_TOP=0
var m2_END_EDGE_TOP=0
var p2_p0_END_EDGE_TOP=0
var theta2_END_EDGE_TOP=0
var p2_p1_END_EDGE_TOP=0


var weak_shock_END_EDGE_BOTTOM=0
var m2_END_EDGE_BOTTOM=0
var p2_p0_END_EDGE_BOTTOM=0
var theta2_END_EDGE_BOTTOM=0
var p2_p1_END_EDGE_BOTTOM=0



var button_advanced_popup_index=null


var saved_files_array=[]
var saved_file_index_selected=0

func _max(list):
	var copy=list.duplicate(true)
	copy.sort()
	var maximum=copy.back()
	
	return maximum
	
func _min(list):
	var copy=list.duplicate()
	copy.sort()
	var minimum=copy.front()
	
	return minimum

func _linspace(start,end,points):
	var s=float(start)
	var e=float(end)
	var p=int(points)
	var list=[]

	for i in range (p):

		list.append(s+((e-s)/(p-1))*i)
	#print(list)
	return list
	
func _index_finder(list,value):
	
	for i in range(len(list)):
		
		if list[i]==value:
			return i
			break
			
		else:
			pass
		
	
func _plate_gradient(i):
	
	if global_var.list_vector[i].x<0.001:
		print("NEGATIVE GRADIENT")
		return 1000000000000000000
		
	else:
		var grad=-global_var.list_vector[i].y/global_var.list_vector[i].x
		return grad
		
		
		
		
		
func _Equation__flowDeflection_shockAngle(mpoint,m):
	var eqn=0
	
	if abs((pow(m,2)*(gamma+cos(2*mpoint))))>0 and abs(tan(mpoint))>0:
		eqn=(2*(1/tan(mpoint))*(pow(m,2)*pow(sin(mpoint),2) -1))/(pow(m,2)*(gamma+cos(2*mpoint)) +2)
	else:
		eqn=100000000000000000000000
		print("error. Check '_Equation__flowDeflection_shockAngle' in global_var...")
		
	return eqn


func _load():
	var new_file=File.new()
	
	if new_file.file_exists("user://saveddata.save"):
		new_file.open("user://saveddata.save",File.READ)
		var dict=parse_json(new_file.get_line())
		return[true,dict]
	else:
		return [false,null]


func _zeroify_list(list):
	
	for i in len(list):
		list[i]=0
		


func _refresh_lists():

	alpha_degrees=0
	alpha_radians=0

	alpha_offset=0 # DEPRECATED

	aerofoil_choice="custom"
	edit_mode=false
#var delete_node=false

#	undo_hover=false
	aerofoil_button_hover=false
#	finish_button_hover=false
	line_mode=0
	pivot_rotation=0
	node_selected=false
	
	list_position.clear()
	list_point_coords.clear()
	list_GlobalPointCoords.clear()
	list_midpoint_pos.clear()
	list_vector.clear()
	list_LocalAngles.clear() # angle relative to chord (i.e. 'half_angle'). Only calculate when a node position is changed, and NOT every frame (as it remains constant)
	list_GlobalAngles.clear()# angle relative to horizontal
	list_strings.clear()
	list_p_p1.clear()
	list_p_p0.clear()
	list_theta.clear()
	list_deflection_angle.clear()
	list_m.clear()
	list_weak_shock_angle.clear()
	list_strong_shock_angle.clear()
	
	index_bottom_top_plate=0
	
	expansion_angle1=0
	expansion_angle2=0
	
	cn_pressures.clear()
	ca_pressures.clear()
	
	t_c=0
	t=0
	c=0
	
	
	cL=0
	cD=0

	cL_plot_list=[]
	cD_plot_list=[]


	execute_program=false

	shock_vs_deflection_points=[]

	error_large_def_angle=false
	error_large_def_angle_ob_shock_func=false
	error_exceeded_dataset_1=false
	error_exceeded_dataset_2=false
	error_exceeded_dataset_3=false
	error_exceeded_dataset_4=false

	times_moved_m_slider=0

	shift_midpoint=false


	save_aerofoil=false
	saved_aerofoil_coords=[]
	saved_aerofoil_point_count=0

	index_start_line_error=0
	
	bow_shock_angle=0
	
	alpha_radians_plot_list.clear()
	
	point_count_before_edit=0
	
	point_coord_before_edit.clear()
	
	
	
	
	
	
	
	aerofoil_geomtery_changed=true

	random_graph_point_color=Color(1.0,1.0,1.0)



	add_node_mode=false
	delete_node_mode=false
	move_node_mode=false
	chord_length_mode=false
	thickness_mode=false


	weak_shock_END_EDGE_TOP=0
	m2_END_EDGE_TOP=0
	p2_p0_END_EDGE_TOP=0
	theta2_END_EDGE_TOP=0
	p2_p1_END_EDGE_TOP=0


	weak_shock_END_EDGE_BOTTOM=0
	m2_END_EDGE_BOTTOM=0
	p2_p0_END_EDGE_BOTTOM=0
	theta2_END_EDGE_BOTTOM=0
	p2_p1_END_EDGE_BOTTOM=0



	button_advanced_popup_index=null
	
	

	