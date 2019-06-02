shader_type canvas_item;

render_mode unshaded, blend_mix;

uniform vec3 random_graph_point_color=vec3(1.0,1.0,1.0);

void fragment(){
	
	COLOR=vec4(random_graph_point_color.r,random_graph_point_color.g,random_graph_point_color.b,1.0);
	
	
}