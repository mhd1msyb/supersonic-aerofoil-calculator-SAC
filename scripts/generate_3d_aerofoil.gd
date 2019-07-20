extends MeshInstance

onready var cube3d_scene=preload("res://scenes/3d_cube.tscn")

var aerofoil_size=global_var.aerofoil_size
var aerofoil_height=global_var.aerofoil_height

func _ready():
	var mat=SpatialMaterial.new()
	mat.albedo_color=ColorN("antiquewhite",1.0)
	material_override=mat # set the material of aerofoil
	
	
	
	
	
	var surftool=SurfaceTool.new()
	mesh=surftool.clear()
	
	var coords=global_var.aerofoil_3d_mesh_coords.duplicate(true)
	
	var x_coords=[]
	var min_x_coord=0
	
	var z_coords=[]
	var min_z_coord=0
	
	for i in range(len(coords)):
		x_coords.append(coords[i].x)
	
	min_x_coord=global_var._min(x_coords)# find minimum x coordinate (in 3d space) so that aerofoil starts from origin (with 0 offset)
	
	
	for i in range(len(coords)):
		z_coords.append(coords[i].z)
	
	min_z_coord=global_var.aerofoil_3d_mesh_coords[0].z # find minimum z coordinate (in 3d space) so that aerofoil starts from origin (with 0 offset)
	
	
	
	for i in range(len(coords)): #final coordinates used to construct mesh
		coords[i]=Vector3(coords[i].x-min_x_coord,0,coords[i].z-min_z_coord)*aerofoil_size
		
	#print(coords)
		
		
		
		
		
	surftool.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)

	for i in range (len(coords)):
		if i<len(coords)-1:
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(coords[i])

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i+1].x,aerofoil_height,coords[i+1].z))
			
			
			
			
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(coords[i])

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i+1].x,0,coords[i+1].z))
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i+1].x,aerofoil_height,coords[i+1].z))
			
		else:

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(coords[i])
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))
			
			
			
			
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(coords[i])
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[0].x,0,coords[0].z))
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))




	
	mesh=surftool.commit(mesh)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#_add_omni(coords)
	_add_cube_pillars(coords)
	

	
	
	
	
func _add_cube_pillars(coords):
	var dimension=0.1
	for i in len(coords):
		var pillar=cube3d_scene.instance()
		add_child(pillar)
		pillar.global_transform.origin=coords[i]
		pillar.scale*=dimension


	for i in len(coords):
		var pillar=cube3d_scene.instance()
		add_child(pillar)
		pillar.global_transform.origin=Vector3(coords[i].x,aerofoil_height,coords[i].z)
		pillar.scale*=dimension


		



func _on_button_back_to_main_scene_pressed():
	global_var._refresh_lists()
	get_tree().change_scene_to(global_var.main_scene)
	pass # replace with function body


	
