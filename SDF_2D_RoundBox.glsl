float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    // length(max(d,0.0))考虑点 p 在Box外部情况，min(max(d.x,d.y),0.0)考虑点 p 在外部情况
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

// b.x = width
// b.y = height
// r.x = roundness top-right  
// r.y = roundness boottom-right
// r.z = roundness top-left
// r.w = roundness bottom-left
//计算一个点 p 到一个带圆角的矩形的有符号距离
float sdRoundBox(in vec2 p, in vec2 b, in vec4 r)
{
    // 根据点 p 坐标选择对应象限圆角进行距离判断
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    // 理解：
    // p 点为非圆角矩形的右上角坐标时 p在矩形边上,q = vec2(0.0, 0.0); sdBox() 返回 0;
    // p 点代入该函数时，p在圆角矩形边外，q = vec2(r.x, r.x)；sdRoundBox() 返回 lengh(q)-r.x;
    vec2 q = abs(p)-b+r.x;// 对圆角内外的1/4扇形区域的处理
    return length(max(q,0.0)) + min(max(q.x,q.y),0.0) - r.x;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 p = (2.0 * fragCoord - iResolution.xy)/iResolution.y;
    vec2 si = vec2(0.9,0.9) ;//+ 0.3*cos(iTime+vec2(0,2));
    vec4 ra = 0.3 + 0.3*cos( 2.0*iTime + vec4(0,1,2,3) );
    ra = min(ra,min(si.x/2.,si.y/2.));//圆角半径小于矩形长宽一半的最小值

	float d = sdRoundBox( p, vec2(si.x/2.,si.y/2.), ra );

    vec3 col = (d>0.0) ? vec3(0.9,0.6,0.3) : vec3(0.65,0.85,1.0);
	col *= 1.0 - exp(-6.0*abs(d));
	col *= 0.8 + 0.2*cos(150.0*d);
	col = mix( col, vec3(1.0), 1.0-smoothstep(0.0,0.01,abs(d)) );

    fragColor = vec4(col, 1.0);
}