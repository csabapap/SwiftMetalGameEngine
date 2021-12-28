import MetalKit

class CubesScene: Scene {
    
    var cubeCollection = CubeCollection(cubeWide: 12, cubeHeight: 12, cubeBack: 12)
    let debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(50)
        
        addCubes()
    }
    
    private func addCubes() {
        addChild(cubeCollection)
    }
    
    override func doUpdate() {
        cubeCollection.setRotationZ(GameTime.DeltaTime)
        cubeCollection.setRotationY(GameTime.DeltaTime / 2)
    }
}
