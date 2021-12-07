//
//  GameView.swift
//  GameEngine
//
//  Created by Csaba Pap on 2021. 11. 23..
//

import MetalKit

class GameView: MTKView {
    
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError( "Failed to get the system's default Metal device." )
        }
        
        self.device = device
        
        Engine.ignite(device: device)
        
        self.clearColor = Preferences.ClearColor
        
        self.colorPixelFormat = Preferences.MainPixelFormat
        
        self.renderer = Renderer()
        self.delegate = renderer
    }
}
