import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    
    override func buildScene() {
        debugCamera.delegate = self
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
        
//        print(Mouse.GetMouseWindowPosition())
//
//        print("viewpost position: \(Mouse.GetMouseViewportPosition())")
        
        super.update(deltaTime: deltaTime)
    }
}

extension SandboxScene: CameraUpdateListener {
    func updateCamera(deltaTime: Float) {
        let firstChild = children[0]
        let lastChild = children[children.endIndex-1]
        
        if (Keyboard.IsKeyPressed(.leftArrow)) {
            let delta = debugCamera.position.x - firstChild.position.x
            if (delta > 0.3) {
                debugCamera.position.x -= deltaTime
            }
        }
        
        if (Keyboard.IsKeyPressed(.rightArrow)) {
            let delta = debugCamera.position.x - lastChild.position.x
            if (delta < -0.3) {
                debugCamera.position.x += deltaTime
            }
        }
        
        if (Keyboard.IsKeyPressed(.upArrow)) {
            let delta = debugCamera.position.y - lastChild.position.y
            if delta < -0.3 {
                debugCamera.position.y += deltaTime
            }
        }
        
        if (Keyboard.IsKeyPressed(.downArrow)) {
            let delta = debugCamera.position.y - firstChild.position.y
            if delta > 0.3 {
                debugCamera.position.y -= deltaTime
            }
        }
    }
}
