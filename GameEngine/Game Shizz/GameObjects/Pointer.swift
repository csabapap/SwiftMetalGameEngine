import MetalKit

class Pointer: GameObject {
    
    private var camera: Camera!
    let rotationIntensity: Float
    
    init(camera: Camera) {
        self.camera = camera
        let random = Int.random(in: 1...10)
        let sign = random <= 5 ? -1 : 1
        rotationIntensity = Float(sign * Int.random(in: 1..<10)) / 100
        super.init(meshType: MeshType.TriangleCustom)
        print("rotation intensity: \(rotationIntensity)")
    }
    
    override func update(deltaTime: Float) {
//        rotation.z += rotationIntensity
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x + camera.position.x, Mouse.GetMouseViewportPosition().y - position.y + camera.position.y)
        super.update(deltaTime: deltaTime)
    }
}
