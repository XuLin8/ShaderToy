#define PI 3.141592653
vec2 GetUV(in vec2 fragCoord)
{
    vec2 uv = fragCoord / min(iResolution.x, iResolution.y);
    uv = 2.0*uv - 1.0;  // 映射到[-1,1]
    uv = 3.*uv;// 映射到[-3,3]
    return uv;
}

vec3 DrawGrid(in vec2 uv)
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

// 判断点p是否在向量ab宽为w的直线上
float isInLine(in vec2 p, in vec2 a, in vec2 b, in float w)
{
    float f = 0.;
    vec2 ab = b - a;
    vec2 ap = p - a;
    float proj = clamp(dot(ab, ap)/dot(ab, ab),0.,1.);// ap在ab上的投影长度 比上 |ab|的值
    float d = length(proj * ab - ap);
    if(d<=w)
    {
        f = 1.;   
    }
    return f;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = GetUV(fragCoord);
    vec3 color = DrawGrid(uv);
    vec2 begin = vec2(uv.x,sin(0.5*sin(iTime)*PI*uv.x));
    vec2 end = vec2(uv.x,cos(uv.x));
    // draw line
    // color += vec3(isInLine(uv,vec2(0.,0.),vec2(1.,1.),fwidth(uv.x)));
    
    // draw sin func
    float inLine = isInLine(uv,begin,begin,fwidth(uv.x));
    color += vec3(inLine,inLine,0.);
    fragColor = vec4(color,1.);
}