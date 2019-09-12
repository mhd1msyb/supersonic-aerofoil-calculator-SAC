shader_type canvas_item;

uniform float blink_speed;

void fragment(){
	vec3 blue=vec3(texture(TEXTURE,UV).r*0.6,texture(TEXTURE,UV).g*0.2,texture(TEXTURE,UV).b);
	vec3 green=vec3(texture(TEXTURE,UV).r*0.3,texture(TEXTURE,UV).g,texture(TEXTURE,UV).b*0.1);
	vec3 colour_transition=mix(blue,green,abs(sin(TIME*blink_speed)));
	COLOR=vec4(colour_transition.rgb,texture(TEXTURE,UV).a);
//	vec4 color=vec4(
	
	
}