import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var quad: Quad = Quad()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(5)
        
        quad.setTexture(textureType: .PartyPirateParot)
        addChild(quad)
        quad.setPositionZ(0.75)
    }
}
