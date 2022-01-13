//
//  LightObject.swift
//  GameEngine
//
//  Created by Csaba Pap on 2022. 01. 03..
//

import MetalKit

class LightObject: GameObject {
    
    var lightData = LightData()
    
    convenience init(name: String) {
        self.init(meshType: .None, name: name)
    }
    
    override func update() {
        self.lightData.position = self.getPosition()
        super.update()
    } 
}

extension LightObject {
    
    func setLightColor(color: float3) {
        lightData.color = color
    }
    
    func getLightColor() -> float3 {
        return lightData.color
    }
    
    // Brightness
    func setLightBrightness(_ brigtness: Float) {
        lightData.brightness = brigtness
    }
    
    func getLightBrightness() -> Float {
        return lightData.brightness
    }
    
    // Ambient intensity
    func setAmbientIntensity(_ intensity: Float) {
        lightData.ambientIntensity = intensity
    }
    
    func getAmbientIntensity() -> Float {
        return lightData.ambientIntensity
    }
    
    // Diffuse intensity
    func setDiffuseIntensity(_ intensity: Float) {
        lightData.diffuseIntensity = intensity
    }
    
    func getDiffuseIntensity() -> Float {
        return lightData.diffuseIntensity
    }
    
    // Specular intensity
    func setSpecularIntensity(_ intesity: Float) {
        lightData.specularIntensity = intesity
    }
    
    func getSpecularIntensity() -> Float {
        return lightData.specularIntensity
    }
}
