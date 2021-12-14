import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var cube: Cube = Cube()
    
    override func buildScene() {
        debugCamera.delegate = self
        addCamera(camera: debugCamera)
        
        debugCamera.position.z = 5
        
        addChild(cube)
        cube.position.z = 0.75
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
