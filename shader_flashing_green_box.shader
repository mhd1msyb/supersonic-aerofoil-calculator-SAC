shader_type canvas_item;

render_mode unshaded, blend_add;


void fragment(){
	
	float flash_speed=3.0;
	
	COLOR=vec4(0.2,0.9,0.1,0.2*abs(sin(TIME*flash_speed)));
	
	
	
}