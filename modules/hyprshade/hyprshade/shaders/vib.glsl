#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

const vec3 LUMA_COEFF = vec3(0.4, 0.4, 0.4);
const float SATTURATION_MULTIPLIER = 1.0;

const vec3 VIB_RGB_BALANCE = vec3(1.0, 1.0, 1.0);
const float VIB_STRENGTH = 0.45;
const vec3 VIB_COEFF = VIB_RGB_BALANCE * VIB_STRENGTH * -1.0;
const float BRIGHTNESS = 0.8;

void main() {
    vec4 pixRGBA = texture(tex, v_texcoord);
    vec3 color = pixRGBA.rgb;

    float luma = dot(LUMA_COEFF, color);

    float colorMax = max(color.r, max(color.g, color.b));
    float colorMin = min(color.r, min(color.g, color.b));

    float satturation = (colorMax - colorMin) * SATTURATION_MULTIPLIER;

    vec3 adjustmentFact = (sign(VIB_COEFF) * satturation - 1.0) * VIB_COEFF + 1.0;

    pixRGBA.rgb = mix(vec3(luma), color, adjustmentFact) * BRIGHTNESS;

    fragColor = pixRGBA;
}
