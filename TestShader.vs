void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // 将 fragCoord（像素坐标）除以视图的分辨率 iResolution.xy，得到了一个在 [0, 1] 范围内的坐标
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = 0.5 + 0.5*cos(iTime + uv.xyx + vec3(0,2,4));
    fragColor = vec4(col,1);
}