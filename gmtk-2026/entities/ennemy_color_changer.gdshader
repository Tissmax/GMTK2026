shader_type canvas_item;

uniform vec4 color: source_color;
uniform vec4 shadow: source_color;
uniform vec4 new_color;
uniform vec4 new_shadow;


void fragment() {
    vec4 current_pixel = texture(TEXTURE, UV);

    COLOR = current_pixel;

    if (current_pixel == color)
        COLOR = new_color;
    else if (current_pixel == shadow)
        COLOR = new_shadow;
}