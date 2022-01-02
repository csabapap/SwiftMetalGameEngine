import MetalKit

class Quad: GameObject {
    
    init() {
        super.init(meshType: .QuadCustom)
        setName("Quad")
    }
    
    override func doUpdate() {
        rotateX(GameTime.DeltaTime * 2)
    }
}
