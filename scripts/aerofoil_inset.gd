#Copyright (c) 2019 Mehdi Msayib#
extends MeshInstance



onready var main_aerofoil_mesh=get_parent().get_node("aerofoil")


var aerofoil_size=global_var.aerofoil_size
var aerofoil_height=global_var.aerofoil_height

func _create_inset(coords):

	var surftool=SurfaceTool.new()
	mesh=surftool.clear()
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
			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))


	mesh=surftool.commit(mesh)




func _create_top_fill(coords):
	var surftool=SurfaceTool.new()
	mesh=surftool.clear()
	surftool.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)

	var outer_coords=global_var.aerofoil_3d_mesh_coords.duplicate(true)

	for i in range (len(coords)-1):
		surftool.add_normal(Vector3(0,0,1))
		surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))

		surftool.add_normal(Vector3(0,0,1))
		surftool.add_vertex(Vector3(outer_coords[i].x,aerofoil_height,outer_coords[i].z))

		surftool.add_normal(Vector3(0,0,1))
		surftool.add_vertex(Vector3(outer_coords[i+1].x,aerofoil_height,outer_coords[i+1].z))




		surftool.add_normal(Vector3(0,0,1))
		surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))

		surftool.add_normal(Vector3(0,0,1))
		surftool.add_vertex(Vector3(coords[i+1].x,aerofoil_height,coords[i+1].z))

		surftool.add_normal(Vector3(0,0,1))
		surftool.add_vertex(Vector3(outer_coords[i+1].x,aerofoil_height,outer_coords[i+1].z))


#		else:
#
#			surftool.add_normal(Vector3(0,0,1))
#			surftool.add_vertex(coords[i])
#
#			surftool.add_normal(Vector3(0,0,1))
#			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
#
#			surftool.add_normal(Vector3(0,0,1))
#			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))
#
#
#
#
#			surftool.add_normal(Vector3(0,0,1))
#			surftool.add_vertex(coords[i])
#
#			surftool.add_normal(Vector3(0,0,1))
#			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))
#
#			surftool.add_normal(Vector3(0,0,1))
#			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))


	mesh=surftool.commit(mesh)



#func _add_omni(coords):
#
#	for i in range(len(coords)):
#		var omni=OmniLight.new()
#		add_child(omni)
#		omni.omni_attenuation=30
#		omni.omni_range=20
#		omni.light_energy=4
#		omni.light_color=Color(randf()*0.7,randf()*0.9,randf())
#		if i<len(coords)-1:
#			omni.global_transform.origin=Vector3(coords[i].x,aerofoil_height,coords[i].z)-global_var.vertex_vectors[i]*8





func _ready():


	var vertex_vectors=global_var.vertex_vectors.duplicate(true)

	var coords=[]

	var coords3d=global_var.aerofoil_3d_mesh_coords.duplicate(true)

	for i in len(coords3d):

		if i==0:
			coords.append(coords3d[i]+vertex_vectors[i])

		if i>0 and i<len(coords3d)-1:
			coords.append(coords3d[i]+vertex_vectors[i])

		if i==len(coords3d)-1:
			coords.append(Vector3())
			coords[i]=coords[0]



	_create_inset(coords)

	_create_top_fill(coords)

	#_add_omni(coords)