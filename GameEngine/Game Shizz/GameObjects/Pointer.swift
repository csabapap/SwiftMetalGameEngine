import MetalKit

class Pointer: GameObject {
    
    private var camera: Camera!
    let rotationIntensity: Float
    
    init(camera: Camera) {
        self.camera = camera
        let random = Int.random(in: 1...10)
        let sign = random <= 5 ? -1 : 1
        rotationIntensity = Float(sign * Int.random(in: 1..<10)) / 100
        super.init(meshType: MeshType.TriangleCustom, name: "Triangle")
        print("rotation intensity: \(rotationIntensity)")
    }
    
    override func doUpdate() {
//        rotation.z += rotationIntensity
        self.setRotationZ(-atan2f(Mouse.GetMouseViewportPosition().x - getPositionX() + camera.getPositionX(), Mouse.GetMouseViewportPosition().y - getPositionY() + camera.getPositionY()))
    }
}
