import simd
class Cube: GameObject {
    
    init() {
        super.init(meshType: .CubeCustom, name: "cube")
    }
    
    override func doUpdate() {
        rotateX(GameTime.DeltaTime)
        rotateY(GameTime.DeltaTime)
    }
}
