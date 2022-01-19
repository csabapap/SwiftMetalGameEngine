import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var sun = Sun()
    var chest = Chest()
    
    var cameraDirection: Float = -1
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(3)
        addCamera(camera: debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        addLight(lightObject: sun)
        
        chest.moveY(-0.5)
//        chest.setTexture(textureType: .PartyPirateParot)
        addChild(chest)
    }
    
    override func doUpdate() {
        if Mouse.IsMouseButtonPressed(button: .left) {
            rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}
