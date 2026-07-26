shader_type canvas_item;

uniform vec4 color: source_color;
uniform vec4 new_color: source_color;
uniform bool active = false;

void fragment() {
    vec4 current_pixel = texture(TEXTURE, UV);

    COLOR = current_pixel;
	if (active) {
	    if (current_pixel.rgb == color.rgb) {
            COLOR = vec4(new_color.rgb, current_pixel.a);
        }
	}

}