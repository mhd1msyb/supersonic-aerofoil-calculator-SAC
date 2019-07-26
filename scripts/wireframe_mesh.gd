extends MeshInstance

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var aerofoil_size=global_var.aerofoil_size
var aerofoil_height=global_var.aerofoil_height

func _ready():

	var mat=SpatialMaterial.new()
	mat.albedo_color=ColorN("springgreen",1.0)
	mat.flags_unshaded=true
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
		
		
		
		
		
		
		
		
	surftool.begin(Mesh.PRIMITIVE_LINES)
	
	
	
	####VERTICAL EDGES WIREFRAME####
	for i in range (len(coords)):
		if i<len(coords)-1:
			surftool.add_vertex(coords[i])
			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
		else:
			break
	
	
	
	
	####TOP PERIPHERY WIREFRAME####
	for i in range (len(coords)):
		if i<len(coords)-1:

			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
			surftool.add_vertex(Vector3(coords[i+1].x,aerofoil_height,coords[i+1].z))
		else:

			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
			surftool.add_vertex(Vector3(coords[0].x,aerofoil_height,coords[0].z))
	
	
	####BOTTOM PERIPHERY WIREFRAME####
	for i in range (len(coords)):
		if i<len(coords)-1:

			surftool.add_vertex(Vector3(coords[i].x,0,coords[i].z))
			surftool.add_vertex(Vector3(coords[i+1].x,0,coords[i+1].z))
		else:

			surftool.add_vertex(Vector3(coords[i].x,0,coords[i].z))
			surftool.add_vertex(Vector3(coords[0].x,0,coords[0].z))
	
	
	mesh=surftool.commit(mesh)
	
	
	