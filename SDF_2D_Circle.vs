float sdCircle( in vec2 p, in float r ) // 点到圆边的距离
{
    return length(p)-r;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (2.0 * fragCoord - iResolution.xy) / min(iResolution.x,iResolution.y);
    vec2 m =(2.0 * iMouse.xy - iResolution.xy) / min(iResolution.x,iResolution.y);
    float d = sdCircle(uv,0.5);

    vec3 col = (d > 0.0)? vec3(0.9,0.6,0.3):vec3(0.65,0.85,1.0);
    col *= 0.8 + 0.2 * cos(150. * d);// ripple
    col *= 1.0 - exp(-8.*abs(d));// black gradient
    col = mix(col,vec3(1.),1.0-smoothstep(0.0,0.01,abs(d)));// white edge

    if(iMouse.z>0.001)// isClick
    {
        d = sdCircle(m,0.5);
        col = mix(col,vec3(1.),1.0-smoothstep(0.0,0.01,length(uv-m)));// center of circle (click point)
        col = mix(col,vec3(1.),1.0-smoothstep(0.0,0.01,abs(length(uv-m)-abs(d))));
    }
    fragColor = vec4(col,1.);
}