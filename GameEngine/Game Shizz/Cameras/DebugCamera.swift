import simd

class DebugCamera: Camera {
    var cameraType: CameraType = .Debug
    
    public var delegate: CameraUpdateListener?
    
    var position: float3 = float3(0)
    
    func update(deltaTime: Float) {
        if let cameraListener = delegate {
            cameraListener.updateCamera(deltaTime: deltaTime)
            return
        }
        
        if (Keyboard.IsKeyPressed(.leftArrow)) {
            self.position.x -= deltaTime
        }

        if (Keyboard.IsKeyPressed(.rightArrow)) {
            self.position.x += deltaTime
        }

        if (Keyboard.IsKeyPressed(.upArrow)) {
            self.position.y += deltaTime
        }

        if (Keyboard.IsKeyPressed(.downArrow)) {
            self.position.y -= deltaTime
        }
    }
}
