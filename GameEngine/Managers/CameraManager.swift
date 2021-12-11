class CameraManager {
    private var cameras: [CameraType: Camera] = [:]
    
    var currentCamera: Camera!
    
    func registerCamera(camera: Camera) {
        self.cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    func setCamera(_ cameraType: CameraType) {
        self.currentCamera = cameras[cameraType]
    }
    
    internal func update(deltaTime: Float) {
        for camera in cameras.values {
            camera.update(deltaTime: deltaTime)
        }
    }
}
