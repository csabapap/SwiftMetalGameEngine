import MetalKit

class CubesScene: Scene {
    
    var cubeCollection = CubeCollection(cubeWide: 12, cubeHeight: 12, cubeBack: 12)
    let debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.position.z = 50
        
        addCubes()
    }
    
    private func addCubes() {
        addChild(cubeCollection)
    }
    
    override func update(deltaTime: Float) {
        cubeCollection.rotation.z += deltaTime
        cubeCollection.rotation.y -= deltaTime / 2
        super.update(deltaTime: deltaTime)
    }
}
