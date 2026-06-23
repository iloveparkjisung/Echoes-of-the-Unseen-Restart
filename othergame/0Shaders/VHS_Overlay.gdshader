shader_type canvas_item;
uniform float alpha : hint_range(0.0, 1.0, 0.1) = 0.5;
void vertex() {

}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.a = alpha;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
