#Copyright (c) 2019 Mehdi Msayib#
extends MeshInstance


onready var main_aerofoil_mesh=get_parent().get_node("aerofoil")


var aerofoil_size=global_var.aerofoil_size
var aerofoil_height=global_var.aerofoil_height
var inset_val=global_var.aerofoil_inset_thickness

func _ready():

	var surftool=SurfaceTool.new()
	mesh=surftool.clear()
	surftool.begin(Mesh.PRIMITIVE_TRIANGLES)

	var coords=global_var.aerofoil_3d_mesh_coords.duplicate(true)



	for i in range (len(coords)):
		if i<len(coords)-1:
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(coords[i])

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i+1].x,aerofoil_height,coords[i+1].z))




		else:

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(coords[i])

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))






	mesh=surftool.commit(mesh)






	var vertex_vectors=[]
	var vec=Vector3(0,0,0)

	var meshdata=MeshDataTool.new()
	meshdata.create_from_surface(mesh,0)
	for i in range(len(coords)-1):
		if i==0:
			vec=(meshdata.get_face_normal(0)+meshdata.get_face_normal(len(coords)-2))*0.5

		if i>0:
			vec=(meshdata.get_face_normal(i-1)+meshdata.get_face_normal(i))*0.5

		vertex_vectors.append(-vec.normalized()*inset_val)
		#print(meshdata.get_face_normal(i))
#
	global_var.vertex_vectors=vertex_vectors

	mesh=surftool.clear()
	#print(global_var.vertex_vectors)