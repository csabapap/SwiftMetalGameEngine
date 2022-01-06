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
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vIn.position, 1);
    
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.color = vIn.color;
    rd.textureCoordinates = vIn.textureCoordinates;
    rd.gameTime = sceneConstants.gameTime;
    rd.worldPosition = worldPosition.xyz;
    rd.surfaceNormal = (modelConstants.modelMatrix * float4(vIn.normal, 1.0)).xyz;
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     constant int &lightCount [[ buffer(2)]],
                                     constant LightData *lightDatas [[ buffer(3) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> texture [[ texture(0) ]]  ) {
    float2 textureCoord = rd.textureCoordinates;
    float4 color;
    if (material.useTexture) {
        color = texture.sample(sampler2d, textureCoord);
    } else if (material.useMaterialColor) {
        color = material.color;
    } else {
        color = rd.color;
    }
    
    if (material.isLit) {
        float3 unitNormal = normalize(rd.surfaceNormal);
        
        float3 totalAmbient = float3(0, 0, 0);
        float3 totalDiffuse = float3(0, 0, 0);
        
        // ambient lighting
        for (int i = 0; i < lightCount; i++) {
            LightData lightData = lightDatas[i];
            float3 ambientness = material.ambient * lightData.ambientIntensity;
            float3 ambientColor = clamp(ambientness * lightData.color * lightData.brightness, 0.0, 1.0);
            totalAmbient += ambientColor;
            
            // diffuse lighting
            float3 unitLightVector = normalize(lightData.position - rd.worldPosition); // worldPosition --> lightPosition
            
            float3 diffuseness = material.diffuse * lightData.diffuseIntensity;
            float nDotL = max(dot(unitNormal, unitLightVector), 0.0);
            float3 diffuseColor = clamp(diffuseness * nDotL * lightData.color * lightData.brightness, 0.0, 1.0);
            totalDiffuse += diffuseColor;
        }
        
        float3 phongIntensity = totalAmbient + totalDiffuse;
        color *= float4(phongIntensity, 1.0);
    }
    return half4(color.r, color.g, color.b, color.a);
}
