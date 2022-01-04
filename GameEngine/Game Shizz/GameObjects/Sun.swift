//
//  Sun.swift
//  GameEngine
//
//  Created by Csaba Pap on 2022. 01. 03..
//

import MetalKit

class Sun: LightObject {
    
    init() {
        super.init(meshType: .Sphere, name: "Sun")
        setColor(color: float4(0.5, 0.5, 0, 1))
    }
}
