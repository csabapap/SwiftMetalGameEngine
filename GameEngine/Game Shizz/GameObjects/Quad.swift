import MetalKit

class Quad: GameObject {
    
    init() {
        super.init(meshType: .QuadCustom)
        setName("Quad")
    }
}
