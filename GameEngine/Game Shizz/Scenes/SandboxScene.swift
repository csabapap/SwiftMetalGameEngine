import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        let count = 5
        for y in -count..<count  {
            for x in -count..<count {
                let player = Pointer(camera: debugCamera)
                player.position.y = (Float(y) + 0.5) / Float(count)
                player.position.x = (Float(x) + 0.5) / Float(count)
                player.scale = float3(0.1)
                addChild(player)
            }
        }
    }
    
    override func update(deltaTime: Float) {
//        let child = children[0]
        // movement with keyboard
//        if Keyboard.IsKeyPressed(KeyCodes.leftArrow) {
//            child.position.x -= deltaTime
//        }
//
//        if Keyboard.IsKeyPressed(KeyCodes.rightArrow) {
//            child.position.x += deltaTime
//        }
//
//        // movement with mouse
//        if Mouse.IsMouseButtonPressed(button: .left) {
//            child.position.x -= deltaTime
//        }
//
//        if Mouse.IsMouseButtonPressed(button: .right) {
//            child.position.x += deltaTime
//        }
        
        print(Mouse.GetMouseWindowPosition())
        
        print("viewpost position: \(Mouse.GetMouseViewportPosition())")
        
        super.update(deltaTime: deltaTime)
    }
}
