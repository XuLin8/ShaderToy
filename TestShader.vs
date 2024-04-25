vec3 DrawGrid(vec2 uv)
{
    vec3 col = vec3(0.);
    vec2 cell = fract(uv);  // 取小数部分 每个整数段uv都分为[0,1]
    if(cell.x < fwidth(uv.x))
    {
        col = vec3(1.0);
    }
    if(cell.y < fwidth(uv.y))
    {
        col = vec3(1.0);
    }
    
    if(abs(uv.x) < fwidth(uv.x)) // fwidth(v) = abs(ddx(v))) + abs(ddy(v));
    {
        col= vec3(.0,1.,0.);
    }
    if(abs(uv.y) < fwidth(uv.y))
    {
        col= vec3(1.0,0.,0.);
    }
    return col;
}
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // 将 fragCoord（像素坐标）除以视图的分辨率 iResolution.xy，得到了一个在 [0, 1] 范围内的坐标
    vec2 uv = fragCoord/iResolution.xy;
  
    uv = 2.0*uv - 1.0;  // 映射到[-1,1]
    uv = 3.*uv;// 映射到[-3,3]

    fragColor = vec4(DrawGrid(uv),1.);
}