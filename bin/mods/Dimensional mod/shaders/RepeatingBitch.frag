//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 u_resolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
//****MAKE SURE TO remove the parameters from mainImage.
//SHADERTOY PORT FIX
#ifdef GL_ES
precision mediump float;
#endif

float alpha = 0;

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

  st *= 1.05; // size each shitter
  st.x += iTime/4;
  st.y -= iTime/4;
  st = fract(st); // Wrap around 1.0
  
  alpha = iTime/-10;
  
  vec4 awesome = texture2D(bitmap, st);
  
  if(awesome.w != 0) //didnt work how i wanted it to but it looked cooler so
  {
    awesome.w = alpha;
  }
  

	gl_FragColor = awesome;
}