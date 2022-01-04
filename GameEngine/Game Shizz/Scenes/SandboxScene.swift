import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var cruiser: Cruiser = Cruiser()
    var character: Character = Character()
    var sun: Sun = Sun()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(5)
        
        sun.setScale(0.5)
        sun.setPositionY(3)
        addLight(lightObject: sun)
        
        cruiser.setScale(0.5)
        addChild(cruiser)
    }
    
    override func doUpdate() {
        if Mouse.IsMouseButtonPressed(button: .left) {
            cruiser.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            cruiser.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}
