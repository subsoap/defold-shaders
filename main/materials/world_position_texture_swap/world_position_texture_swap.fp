varying highp vec4 var_position;
varying mediump vec3 var_normal;
varying mediump vec2 var_texcoord0;
varying highp vec4 var_light;

uniform lowp sampler2D tex0;
uniform lowp sampler2D tex1;

uniform lowp vec4 tint;
uniform highp vec4 swap_position;

void main()
{
    
    // Pre-multiply alpha since all runtime textures already are
    vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    vec4 color_1 = texture2D(tex0, var_texcoord0.xy) * tint_pm;
    vec4 color_2 = texture2D(tex1, var_texcoord0.xy) * tint_pm;

    // Diffuse light calculations
    vec3 ambient_light = vec3(0.2);
    vec3 diff_light = vec3(normalize(var_light.xyz - var_position.xyz));
    diff_light = max(dot(var_normal,diff_light), 0.0) + ambient_light;
    diff_light = clamp(diff_light, 0.0, 1.0);

    // word position texture swap
    vec3 swap_distance = distance(var_position.xyz, swap_position.xyz);
    vec3 sphere = 1.0 - clamp(swap_distance / 1000.0, 0.0, 1.0); // saturate, 100 = magic number radius
    
    vec3 color_comp = step(sphere.x, 0.1) * color_1.rgb + step(0.1, sphere.x) * color_2.rgb;
    
    gl_FragColor = vec4(color_comp*diff_light,1.0);
}

