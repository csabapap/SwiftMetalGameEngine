//
//  PartyParrotScene.swift
//  GameEngine
//
//  Created by Csaba Pap on 2022. 01. 13..
//

class PartyParotScene: Scene {
        
    var camera = DebugCamera()
    var quad = Quad()
    var sun = Sun()
    
    override func buildScene() {
        camera.setPosition(0, 0, 4)
        addCamera(camera: camera)
        
        sun.setPosition(0, 2, 2)
        sun.setMaterialIsLit(false)
        sun.setLightBrightness(0.3)
        sun.setMaterialColor(float4(1, 1, 1, 1))
        sun.setLightColor(color: float3(1, 1, 1))
        addLight(lightObject: sun)
        
        quad.setMaterialAmbient(0.01)
        quad.setMaterialShininess(10)
        quad.setMaterialSpecular(5)
        quad.useBaseColorTexture(textureType: .PartyPirateParot)
        addChild(quad)
        
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            quad.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            quad.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}
