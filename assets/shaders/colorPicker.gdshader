shader_type canvas_item;

uniform vec4 stripePrimary_utitilyMap : source_color; // stripe: green w blue
//uniform vec4 stripeSecondary_utitilyMap : source_color; // stripe: green w blue
uniform vec4 tailPrimary_utitilyMap : source_color; // stripe: green w blue
//uniform vec4 tailSecondary_utitilyMap : source_color; // stripe: green w blue
//uniform vec4 tailTertiary_utitilyMap : source_color; // stripe: green w blue
uniform vec4 body_utitilyMap : source_color; // stripe: green w blue
//uniform vec4 fins_utitilyMap : source_color; // stripe: green w blue

uniform vec4 stripePrimary_set : source_color;
uniform vec4 tailPrimary_set : source_color;
uniform vec4 body_set : source_color;

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	
	if (current_color == stripePrimary_utitilyMap) {
		COLOR = stripePrimary_set;
	}
	else if (current_color == tailPrimary_utitilyMap) {
		COLOR = tailPrimary_set;
	}
	else if (current_color == body_utitilyMap) {
		COLOR = body_set;
	}
	else {
		COLOR =current_color;
	}
}







