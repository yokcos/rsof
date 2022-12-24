shader_type canvas_item;

uniform sampler2D noise;
uniform vec2 centre = vec2(0.5, 0.5);
uniform float vignette_intensity = 1.0;

vec4 blur(sampler2D tex, vec2 uv, float direction, float magnitude) {
	float total = 0.0;
	vec4 total_colour = vec4(0.0, 0.0, 0.0, 0.0);
	vec4 original_colour = texture(tex, uv);
	
	for (int i = -3; i <= 3; i ++) {
		vec2 this_uv = uv + magnitude*float(i)*vec2( cos(direction), -sin(direction) );
		float this_factor = 1.0 - abs(float(i)) / 4.0;
		
		total_colour += this_factor * texture(tex, this_uv);
		total += this_factor;
	}
	
	vec4 final_colour = total_colour / total;
	float original_brightness = original_colour.r + original_colour.g + original_colour.b;
	float final_brightness = final_colour.r + final_colour.g + final_colour.b;
	
	if (final_brightness > original_brightness) {
		return final_colour;
	} else {
		return original_colour;
	}
}

void fragment() {
	vec2 noise_uv = UV;
	noise_uv.y *= 9.0/16.0; // Adjusting for the aspect ratio of the screen
	noise_uv.y -= TIME * 0.05;
	float noise_factor = texture(noise, noise_uv).r;
	
	vec2 target_uv = SCREEN_UV;
	target_uv += noise_factor * SCREEN_PIXEL_SIZE * 5.0;
	vec4 original_colour = blur(SCREEN_TEXTURE, target_uv, .2, 2.0*SCREEN_PIXEL_SIZE.x);
	vec4 modified_colour = original_colour;
	
	float vignette_noise_factor = 1.0 - 0.2*noise_factor;
	float vignette = length( UV - centre )*vignette_intensity * vignette_noise_factor;
	modified_colour = mix( original_colour, vec4(1.0, 1.0, 1.0, 1.0), vignette );
	
	COLOR = modified_colour;
}
