//
//  LightManager.swift
//  GameEngine
//
//  Created by Csaba Pap on 2022. 01. 03..
//

import MetalKit

class LightManager {
    private var lightObjects: [LightObject] = []
    
    func addLightObject(_ lightObject: LightObject) {
        lightObjects.append(lightObject)
    }
    
    func gatherLightData() -> [LightData] {
        return lightObjects.map { $0.lightData }
    }
    
    func setLightData(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var lightDatas = gatherLightData()
        renderCommandEncoder.setFragmentBytes(&lightDatas, length: LightData.size(lightDatas.count), index: 2)
    }
}
