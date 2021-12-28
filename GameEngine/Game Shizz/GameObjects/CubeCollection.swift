import MetalKit

class CubeCollection: InstancedGameObject {
    
    let cubeWide: Int
    let cubeHeight: Int
    let cubeBack: Int
    
    var time: Float = 0
    
    init(cubeWide: Int, cubeHeight: Int, cubeBack: Int) {
        self.cubeWide = cubeWide
        self.cubeHeight = cubeHeight
        self.cubeBack = cubeBack
        super.init(meshType: .CubeCustom, instanceCount: cubeWide * cubeHeight * cubeBack)
        
        setName("Cube Collection")
        
        setColor(color: ColorUtils.randomColor())
    }
    
    override func doUpdate() {
        var index = 0
        
        let xRange: Float = Float(cubeWide / 2)
        let yRange: Float = Float(cubeHeight / 2)
        let zRange: Float = Float(cubeBack / 2)
        
        let gap: Float = cos(time / 2) * 10
        for y in stride(from: -yRange, to: yRange, by: 1.0) {
            let posY = Float(y * gap)
            for x in stride(from: -xRange, to: xRange, by: 1.0) {
                let posX = Float(x * gap)
                for z in stride(from: -zRange, to: zRange, by: 1.0) {
                    print("index: \(index)" )
                    let posZ = Float(z * gap)
                    nodes[index].setPositionX(posX)
                    nodes[index].setPositionY(Float(posY))
                    nodes[index].setPositionZ(Float(posZ))
                    nodes[index].rotateZ(-GameTime.DeltaTime * 2)
                    nodes[index].rotateY(-GameTime.DeltaTime * 2)
                    nodes[index].setScale(0.3)
                    index += 1
                }
            }
        }
    }
}
