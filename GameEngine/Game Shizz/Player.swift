import MetalKit

class Player: GameObject {
    
    let rotationIntensity: Float
    
    init() {
        let random = Int.random(in: 1...10)
        let sign = random <= 5 ? -1 : 1
        rotationIntensity = Float(sign * Int.random(in: 1..<10)) / 100
        super.init(meshType: MeshType.TriangleCustom)
        print("rotation intensity: \(rotationIntensity)")
    }
    
    override func update(deltaTime: Float) {
//        rotation.z += rotationIntensity
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x, Mouse.GetMouseViewportPosition().y - position.y)
        super.update(deltaTime: deltaTime)
    }
}
