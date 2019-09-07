shader_type canvas_item;

render_mode unshaded, blend_add;
uniform float flash_speed=10.0;
uniform vec4 colour=vec4(0.2,0.9,0.1,0.9);


void fragment(){
	//vec3 colour_=vec3(0.2,0.9,0.1);
	COLOR=colour;
	COLOR.a=abs(sin(TIME*flash_speed));
	
	
	
}