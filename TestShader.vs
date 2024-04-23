void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // 将 fragCoord（像素坐标）除以视图的分辨率 iResolution.xy，得到了一个在 [0, 1] 范围内的坐标
    vec2 uv = fragCoord/iResolution.xx - 0.5*iResolution.xy/iResolution.xx;
    vec3 col = 0.5 + 0.5*cos(iTime + uv.xyx + vec3(0,2,4));
    float c = length(uv);
    if(c<.1)
        c=1.;
    fragColor = vec4(vec3(c),1);
}