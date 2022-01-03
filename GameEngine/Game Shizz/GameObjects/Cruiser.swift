import MetalKit

class Cruiser: GameObject {
    
    init() {
        super.init(meshType: .Cruiser)
        setName("Crusier")
        setTexture(textureType: .Cruiser)
    }
}
