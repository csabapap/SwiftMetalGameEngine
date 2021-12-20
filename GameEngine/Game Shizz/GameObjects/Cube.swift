class Cube: GameObject {
    init() {
        super.init(meshType: .CubeCustom)
    }
    
    override func update(deltaTime: Float) {
        rotation.x += Float.randomZeroToOne * deltaTime
        rotation.y += Float.randomZeroToOne * deltaTime
        super.update(deltaTime: deltaTime)
    }
}
