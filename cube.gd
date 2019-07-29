#Copyright (c) 2019 Mehdi Msayib#
extends MeshInstance

onready var cube3d_scene=preload("res://scenes/3d_cube.tscn")

var aerofoil_size=global_var.aerofoil_size
var aerofoil_height=global_var.aerofoil_height

func _ready():
	var surftool=SurfaceTool.new()
	mesh=surftool.clear()
	
	var coords=[Vector3(1,0,1),Vector3(-1,0,1),Vector3(-1,0,-1),Vector3(1,0,-1)]

	for i in len(coords):
		coords[i]*=3
		
		
		
		
		
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

	
	
	
	
	
