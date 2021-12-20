import MetalKit

class CubesScene: Scene {
    
    let debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.position.z = 13
        
        addCubes()
    }
    
    private func addCubes() {
        for y in -5..<5 {
            let posY = Float(y) + 0.5
            for x in -8..<8 {
                let posX = Float(x) + 0.5
                let cube = Cube()
                cube.position.y = Float(posY)
                cube.position.x = Float(posX)
                cube.scale = float3(0.3)
                cube.setColor(color: ColorUtils.randomColor())
                addChild(cube)
            }
        }
    }
}
