class Cube: GameObject {
    init() {
        super.init(meshType: .CubeCustom)
    }
    
    override func update(deltaTime: Float) {
        rotation.z += deltaTime
        rotation.y += deltaTime / 2
        super.update(deltaTime: deltaTime)
    }
}
