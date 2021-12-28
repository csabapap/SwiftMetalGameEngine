import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var quad: Quad = Quad()
    
    override func buildScene() {
//        debugCamera.delegate = self
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(5)
        
        addChild(quad)
        quad.setPositionZ(0.75)
    }
    
    override func doUpdate() {
        quad.setPositionX(cos(GameTime.TotalGameTime))
    }
}

//extension SandboxScene: CameraUpdateListener {
//    func updateCamera(deltaTime: Float) {
//        let firstChild = children[0]
//        let lastChild = children[children.endIndex-1]
//
//        if (Keyboard.IsKeyPressed(.leftArrow)) {
//            let delta = debugCamera.position.x - firstChild.getPositionX()
//            if (delta > 0.3) {
//                debugCamera.position.x -= deltaTime
//            }
//        }
        
//        if (Keyboard.IsKeyPressed(.rightArrow)) {
//            let delta = debugCamera.getPositionX() - lastChild.getPositionX()
//            if (delta < -0.3) {
//                debugCamera.moveX(deltaTime)
//            }
//        }
//        
//        if (Keyboard.IsKeyPressed(.upArrow)) {
//            let delta = debugCamera.getPositionY() - lastChild.getPositionY()
//            if delta < -0.3 {
//                debugCamera.moveY(deltaTime)
//            }
//        }
//        
//        if (Keyboard.IsKeyPressed(.downArrow)) {
//            let delta = debugCamera.getPositionY() - firstChild.getPositionY()
//            if delta > 0.3 {
//                debugCamera.moveY(-deltaTime)
//            }
//        }
//    }
//}
