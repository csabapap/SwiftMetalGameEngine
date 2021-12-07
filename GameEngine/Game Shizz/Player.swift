class Player: GameObject {
    
    let rotationIntensity: Float
    
    init() {
        let random = Int.random(in: 1...10)
        let sign = random <= 5 ? -1 : 1
        rotationIntensity = Float(sign * Int.random(in: 1..<10)) / 100
        super.init(meshType: MeshType.QuadCustom)
        print("rotation intensity: \(rotationIntensity)")
    }
    
    override func update(deltaTime: Float) {
        rotation.z += rotationIntensity
        super.update(deltaTime: deltaTime)
    }
}
