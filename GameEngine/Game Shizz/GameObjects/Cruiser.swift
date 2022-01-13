import MetalKit

class Cruiser: GameObject {
    
    init() {
        super.init(meshType: .Cruiser, name: "Crusier")
        setTexture(textureType: .Cruiser)
    }
}
