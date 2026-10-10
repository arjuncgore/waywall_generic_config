attribute vec2 v_src_pos;
attribute vec2 v_dst_pos;

uniform vec2 u_src_size;
uniform vec2 u_dst_size;

varying vec2 f_src_pos;

void main() {
    gl_Position.x = 2.0 * (v_dst_pos.x / u_dst_size.x) - 1.0;
    gl_Position.y = 1.0 - 2.0 * (v_dst_pos.y / u_dst_size.y);
    gl_Position.zw = vec2(1.0);

    f_src_pos = v_src_pos / u_src_size;
}

// vim:ft=glsl
