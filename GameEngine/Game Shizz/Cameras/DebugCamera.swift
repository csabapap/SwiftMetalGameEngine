import simd

class DebugCamera: Camera {
    var cameraType: CameraType = .Debug
    
    public var delegate: CameraUpdateListener?
    
    var position: float3 = float3(0)
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45,
                                           aspectRatio: Renderer.AspectRatio,
                                           near: 0.1,
                                           far: 1000)
    }
    
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
