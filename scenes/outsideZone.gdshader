shader_type canvas_item;

uniform sampler2D outside_texture; // The texture for the outside area
uniform vec2 center; // Center of the shrinking area
uniform float radius; // Radius for the inside circle to discard
uniform vec2 screen_size; // The size of the screen or TextureRect

void fragment() {
    // Calculate the distance from the fragment to the center
    float distance_to_center = length(FRAGCOORD.xy - center);
    
    // If inside the circle, discard the pixel
    if (distance_to_center < radius) {
        discard;
    }
    
    // Sample the texture using normalized coordinates
    vec2 uv = FRAGCOORD.xy / screen_size;
    vec4 tex_color = texture(outside_texture, uv);
    
    // Set the color to the texture
    COLOR = tex_color;
}
