#ifndef LIGHTING_METAL
#define LIGHTING_METAL
#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

class Lighting {
    public:
        static float3 getPhongIntensity(constant Material &material,
                                        constant LightData *lightDatas,
                                        int lightCount,
                                        float3 worldPosition,
                                        float3 unitNormal,
                                        float3 unitToCameraVector) {
            float3 totalAmbient = float3(0, 0, 0);
            float3 totalDiffuse = float3(0, 0, 0);
            float3 totalSpecular = float3(0, 0, 0);
            
            for (int i = 0; i < lightCount; i++) {
                LightData lightData = lightDatas[i];
                
                float3 unitLightVector = normalize(lightData.position - worldPosition); // worldPosition --> lightPosition
                float3 unitReflectionVector = normalize(reflect(-unitLightVector, unitNormal)); // R vector
            
                // ambient lighting
                float3 ambientness = material.ambient * lightData.ambientIntensity;
                float3 ambientColor = clamp(ambientness * lightData.color * lightData.brightness, 0.0, 1.0);
                totalAmbient += ambientColor;
                
                // diffuse lighting
                float3 diffuseness = material.diffuse * lightData.diffuseIntensity;
                float nDotL = max(dot(unitNormal, unitLightVector), 0.0);
                float3 diffuseColor = clamp(diffuseness * nDotL * lightData.color * lightData.brightness, 0.0, 1.0);
                totalDiffuse += diffuseColor;
                
                // specular lighting
                float3 specularness = material.specular * lightData.specularIntensity;
                float rDotV = max(dot(unitReflectionVector, unitToCameraVector), 0.0);
                float specularExp = pow(rDotV, material.shininess);
                float3 specularColor = clamp(specularness * specularExp * lightData.color * lightData.brightness, 0.0, 1.0);
                totalSpecular += specularColor;
            }
            
            float3 phongIntensity = totalAmbient + totalDiffuse + totalSpecular;
            return phongIntensity;
        }
};
#endif
