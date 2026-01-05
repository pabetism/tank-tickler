shader_type canvas_item;


const vec4 utilityMap1pri  = vec4(0.0, 1.0, 0.0, 1.0); // green - main stripe
const vec4 utilityMap1sec  = vec4(0.0, 0.0, 1.0, 1.0); // blue -  below main stripe/eye

const vec4 utilityMap2pri  = vec4(1.0, 0.0, 1.0, 1.0);// magenta - tail stripe bright
const vec4 utilityMap2sec  = vec4(0.0, 1.0, 1.0, 1.0); // cyan - tail stripe dark
const vec4 utilityMap2ter  = vec4(1.0, 1.0, 0.0, 10.0); // yellow - tail stripe accent

const vec4 utilityMap3pri  = vec4(0.0, 0.0, 0.0, 1.0); //black - body
const vec4 utilityMap3sec = vec4(1.0, 0.0, 0.0, 1.0); //red - fins



uniform vec4 colorSet_1pri ;
uniform vec4 colorSet_1sec ;

uniform vec4 colorSet_2pri ;
uniform vec4 colorSet_2sec ;
uniform vec4 colorSet_2ter ;

uniform vec4 colorSet_3pri ;
uniform vec4 colorSet_3sec ;

uniform float tolerance : hint_range(0,1);

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	
	float dist_1pri = distance(tex_color.rgb, utilityMap1pri.rgb);
	float dist_1sec = distance(tex_color.rgb, utilityMap1sec.rgb);
	
	float dist_2pri = distance(tex_color.rgb, utilityMap2pri.rgb);
	float dist_2sec = distance(tex_color.rgb, utilityMap2sec.rgb);
	float dist_2ter = distance(tex_color.rgb, utilityMap2ter.rgb);
	
	float dist_3pri = distance(tex_color.rgb, utilityMap3pri.rgb);
	float dist_3sec = distance(tex_color.rgb, utilityMap3sec.rgb);
	
	if (dist_1pri < tolerance) {
		tex_color.rgb = colorSet_1pri.rgb;
	}
	else if (dist_1sec < tolerance) {
		tex_color.rgb = colorSet_1sec.rgb;
	}
	else if (dist_2pri < tolerance) {
		tex_color.rgb = colorSet_2pri.rgb;
	}
	else if (dist_2sec < tolerance) {
		tex_color.rgb = colorSet_2sec.rgb;
	}
	else if (dist_2ter < tolerance) {
		tex_color.rgb = colorSet_2ter.rgb;
	}
	else if (dist_3pri < tolerance) {
		tex_color.rgb = colorSet_3pri.rgb;
	}
	else if (dist_3sec < tolerance) {
		tex_color.rgb = colorSet_3sec.rgb;
		//tex_color.a = colorSet_3sec.a; //adding this line causes other totally transparent cells to become visible. this reddit post might be helpful when I'm not hungry: https://www.reddit.com/r/godot/comments/1adyy8w/2d_fragment_shader_changing_alpha_adds_pixels/
	}
	
	COLOR = tex_color;
}