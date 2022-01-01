//
//  MyShaders.metal
//  GameEngine
//
//  Created by Csaba Pap on 2021. 11. 23..
//

#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]){
    RasterizerData rd;
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    rd.textureCoordinates = vIn.textureCoordinates;
    rd.gameTime = sceneConstants.gameTime;
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]]) {
//    float4 color = material.useMaterialColor ? material.color : rd.color;
    float x = rd.textureCoordinates.x;
    float y = rd.textureCoordinates.y;
    float red = sin((x + rd.gameTime) * 20);
    float green = sin((y - rd.gameTime) * 20);
    float blue = tan((x + rd.gameTime) * 20);
    
    float4 color = float4(red, green, blue, 1);
    
    return half4(color.r, color.g, color.b, color.a);
}
