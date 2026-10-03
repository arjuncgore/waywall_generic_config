
varying vec2 f_src_pos;

uniform sampler2D u_texture;

// ==== THRESHOLD ====
const float threshold = 0.005;

// ==== SRC COLORS ====
const vec3 entities         = vec3(0.894, 0.275, 0.769);        // #E446C4

const vec3 unspecified      = vec3(0.275, 0.808, 0.400);        // #46CE66
const vec3 destroyProgress  = vec3(0.800, 0.424, 0.275);        // #CC6C46
const vec3 prepare          = vec3(0.275, 0.298, 0.275);        // #464C46

const vec3 blockentities    = vec3(0.925, 0.431, 0.306);        // #EC6E4E

void main() {
    vec4 color = texture2D(u_texture, f_src_pos);

    bool is_blockentities = all(lessThan(abs(color.rgb - blockentities), vec3(threshold)));
    bool is_entities = all(lessThan(abs(color.rgb - entities), vec3(threshold)));
    bool is_unspecified = all(lessThan(abs(color.rgb - unspecified), vec3(threshold)));
    bool is_destroyProgess = all(lessThan(abs(color.rgb - destroyProgress), vec3(threshold)));
    bool is_prepare = all(lessThan(abs(color.rgb - prepare), vec3(threshold)));


    if ( is_entities ) {
        gl_FragColor = pie1_color;
    }
    else if ( is_unspecified || is_destroyProgess || is_prepare ) {
        gl_FragColor = pie2_color;
    }
    else if ( is_blockentities ) {
        gl_FragColor = pie3_color;
    }
    else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}

// vim:ft=glsl
