import MetalKit

class Scene: Node {
    
    private var cameraManager = CameraManager()
    private var lightManager = LightManager()
    private var sceneConstants = SceneConstants()
    
    init() {
        super.init(name: "Scene")
        buildScene()
    }
    
    func buildScene() { }
    
    func addCamera(camera: Camera, isCurrentCamera: Bool = true) {
        cameraManager.registerCamera(camera: camera)
        if (isCurrentCamera) {
            cameraManager.setCamera(camera.cameraType)
        }
    }
    
    func addLight(lightObject: LightObject) {
        self.addChild(lightObject)
        lightManager.addLightObject(lightObject)
    }
    
    func updateSceneConstants() {
        sceneConstants.viewMatrix = cameraManager.currentCamera.viewMatrix
        sceneConstants.projectionMatrix = cameraManager.currentCamera.projectionMatrix
        sceneConstants.gameTime = GameTime.TotalGameTime
        sceneConstants.cameraPosition = cameraManager.currentCamera.getPosition()
    }
    
    func updateCameras(deltatTime: Float) {
        cameraManager.update(deltaTime: deltatTime)
    }
    
    override func update() {
        updateSceneConstants()
        super.update()
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        lightManager.setLightData(renderCommandEncoder)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
