#Copyright (c) 2019 Mehdi Msayib#
extends MeshInstance


var aerofoil_size=0.03
var aerofoil_height=10

func _ready():
	var surftool=SurfaceTool.new()
	var coords=global_var.aerofoil_3d_mesh_coords

		
	#print(coords)
		
		
		
	surftool.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	
	
	
	
	for i in range (len(coords)):
		if i==0:
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i].x,aerofoil_height,coords[i].z))
	
			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[i+1].x,aerofoil_height,coords[i+1].z))

			surftool.add_normal(Vector3(0,0,1))
			surftool.add_vertex(Vector3(coords[len(coords)-2].x,aerofoil_height,coords[len(coords)-2].z))
			
		if i>0 and i<global_var.index_bottom_top_plate:
			var top_count=len(coords)-global_var.index_bottom_top_plate-1
			var bottom_count=len(coords)-top_count-3
			
			var rang=0
			
			if bottom_count>top_count:
				rang=bottom_count+1
			if bottom_count<top_count:
				rang=top_count-1
			if bottom_count==top_count:
				rang=top_count-1 # doesnt matter in this case (i.e. could've chosen 'bottom_count')
			
			
			var list_min_x=[]
			
			for i in range(rang):
				var x=abs(coords[i].x-coords[len(coords)-1-i].x)
				if x>0:
					list_min_x.append(x)
			
			var min_val=global_var._min(list_min_x)
			
			var index=global_var._index_finder(list_min_x,min_val)
			
			print(index)
			

			
	mesh=surftool.commit(mesh)