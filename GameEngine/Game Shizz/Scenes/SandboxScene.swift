import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var cruiser: Cruiser = Cruiser()
    var character: Character = Character()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(5)
        
        character.setScale(0.5)
        addChild(character)
    }
    
    override func doUpdate() {
        if Mouse.IsMouseButtonPressed(button: .left) {
            character.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            character.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}
