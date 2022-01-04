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
    
    init(meshType: MeshType, name: String) {
        super.init(meshType: meshType)
        self._name = name
    }
    
    override func update() {
        self.lightData.position = self.getPosition()
        super.update()
    } 
}
