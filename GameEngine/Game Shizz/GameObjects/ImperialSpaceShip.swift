import MetalKit

class ImperialSpaceShip: GameObject {
    init() {
        super.init(meshType: .Imperial, name: "Imperial Space Ship")
//        setMaterialColor(color: float4(1.0, 0.2, 0.2, 1.0))
        setTexture(textureType: .Imperial)
        setScale(0.1)
    }
}
