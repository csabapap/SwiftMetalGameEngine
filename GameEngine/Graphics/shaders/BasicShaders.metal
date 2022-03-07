//
//  MyShaders.metal
//  GameEngine
//
//  Created by Csaba Pap on 2021. 11. 23..
//

#include <metal_stdlib>
#include "Lighting.metal"
#include "Shared.metal"
using namespace metal;

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]){
    RasterizerData rd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vIn.position, 1);
    
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.color = vIn.color;
    rd.textureCoordinates = vIn.textureCoordinates;
    rd.gameTime = sceneConstants.gameTime;
    rd.worldPosition = worldPosition.xyz;
    rd.toCameraVector = sceneConstants.cameraPosition - worldPosition.xyz;
    
    rd.surfaceNormal = (modelConstants.modelMatrix * float4(vIn.normal, 0.0)).xyz;
    rd.surfaceTangent = (modelConstants.modelMatrix * float4(vIn.tangent, 0.0)).xyz;
    rd.surfaceBitangent = (modelConstants.modelMatrix * float4(vIn.bitangent, 0.0)).xyz;
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     constant int &lightCount [[ buffer(2)]],
                                     constant LightData *lightDatas [[ buffer(3) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> baseColorMap [[ texture(0) ]],
                                     texture2d<float> normalMap [[ texture(1) ]]) {
    float2 textureCoord = rd.textureCoordinates;
    float4 color = material.color;
    if (!is_null_texture(baseColorMap)) {
        color = baseColorMap.sample(sampler2d, textureCoord);
    }
    
    if (material.isLit) {
        
        float3 unitNormal = normalize(rd.surfaceNormal);
        
        if (!is_null_texture(normalMap)) {
            float3 sampleNormal = normalMap.sample(sampler2d, textureCoord).rgb * 2 - 1;
            float3x3 TBN = {rd.surfaceTangent, rd.surfaceBitangent, rd.surfaceNormal};
            unitNormal = TBN * sampleNormal;
        }
        
        float3 unitToCameraVector = normalize(rd.toCameraVector); // v vector
        float3 phongIntensity = Lighting::getPhongIntensity(material,
                                                            lightDatas,
                                                            lightCount,
                                                            rd.worldPosition,
                                                            unitNormal,
                                                            unitToCameraVector);
        color *= float4(phongIntensity, 1.0);
    }
    return half4(color.r, color.g, color.b, color.a);
}
