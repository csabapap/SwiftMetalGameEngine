import MetalKit

class Quad: GameObject {
    
    init() {
        super.init(meshType: .QuadCustom)
        setName("Quad")
        
        var cube = Cube()
        cube.setScale(0.3)
        addChild(cube)
    }
}
