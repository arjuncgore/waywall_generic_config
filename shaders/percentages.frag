
varying vec2 f_src_pos;

uniform sampler2D u_texture;

// ==== THRESHOLD ====
const float threshold = 0.005;

// ==== SRC COLORS ====
const vec3 blockentities    = vec3(0.914, 0.427, 0.302);        // #E96D4D
const vec3 unspecified      = vec3(0.271, 0.796, 0.396);        // #45CB65

void main() {
    vec4 color = texture2D(u_texture, f_src_pos);

    bool is_blockentities = all(lessThan(abs(color.rgb - blockentities), vec3(threshold)));
    bool is_unspecified = all(lessThan(abs(color.rgb - unspecified), vec3(threshold)));

    if ( is_blockentities ) {
        gl_FragColor = pie1_color;
    }
    else if ( is_unspecified ) {
        gl_FragColor = pie2_color;
    }
    else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}

// vim:ft=glsl
