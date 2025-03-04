precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

const vec3 LUMA_COEFF = vec3(0.4, 0.4, 0.4);

const float SATTURATION_MULTIPLIER = 1.0;

const vec3 VIB_RGB_BALANCE = vec3(1.0, 1.0, 1.0);
const float VIB_STRENGTH = 0.175;
const vec3 VIB_COEFF = VIB_RGB_BALANCE * VIB_STRENGTH * -1.0;

void main() {
    vec4 pixRGBA = texture2D(tex, v_texcoord);
    vec3 color = vec3(pixRGBA[0], pixRGBA[1], pixRGBA[2]);

    float luma = dot(LUMA_COEFF, color);

    float colorMax = max(color[0], max(color[1], color[2]));
    float colorMin = min(color[0], min(color[1], color[2]));

    float satturation = (colorMax - colorMin) * SATTURATION_MULTIPLIER;

    vec3 adjustmentFact = (sign(VIB_COEFF) * satturation - 1.0) * VIB_COEFF + 1.0;

    pixRGBA[0] = mix(luma, color[0], adjustmentFact[0]);
    pixRGBA[1] = mix(luma, color[1], adjustmentFact[1]);
    pixRGBA[2] = mix(luma, color[2], adjustmentFact[2]);

    gl_FragColor = pixRGBA;
}

