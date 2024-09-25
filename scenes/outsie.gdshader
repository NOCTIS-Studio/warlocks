shader_type canvas_item;

uniform vec2 center;
uniform float radius;

void fragment() {
    float distance_to_center = length(FRAGCOORD.xy - center);
    if (distance_to_center < radius) {
        discard; // Discard pixels inside the radius
    }
    // Set the outside area color
    COLOR = vec4(1.0, 0.0, 0.0, 1.0); // Example: Red color for outside
}
