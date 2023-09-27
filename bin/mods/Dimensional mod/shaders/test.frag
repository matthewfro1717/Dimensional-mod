#pragma header
// chatgpt coded this lmfao
// i added the uniforms and modified the "vec3 tinted" line, then ported to make it work
uniform float red = 0.0;
uniform float green = 0.0;
uniform float blue = 0.0;

void main()
{
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv.xy); // Get the texture color
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // Convert to grayscale
    vec3 tinted = vec3(gray) * vec3(red / 255.0, green / 255.0, blue / 255.0); // Apply the tint (using sepia tones)
    gl_FragColor = vec4(tinted, color.a); // Set the output color
}