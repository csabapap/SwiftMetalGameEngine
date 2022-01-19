//
//  Chest.swift
//  GameEngine
//
//  Created by Csaba Pap on 2022. 01. 18..
//

import MetalKit

class Chest: GameObject {
    
    init() {
        super.init(meshType: .Chest, name: "Chest")
        setScale(0.01)
    }
}
