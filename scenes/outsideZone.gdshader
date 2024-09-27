shader_type canvas_item;

uniform vec2 center;
uniform float radius;
uniform float border_width;
uniform vec4 outside_color;

void fragment() {
    vec2 local_coords = FRAGCOORD.xy;
    float dist = distance(slocal_coords, center);

    if (dist > radius + border_width) {
        COLOR = outside_color;
    } else if (dist > radius) {
        // Calculate the border color based on the distance from the radius
        float border_factor = (dist - radius) / border_width;
        COLOR = mix(outside_color, vec4(0.0, 0.0, 0.0, 1.0), border_factor);
    } else {
        discard; // Discard pixels inside the radius
    }
}