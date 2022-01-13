import MetalKit

class Engine {
    public static var device: MTLDevice!
    public static var commandQueue: MTLCommandQueue!
    public static var defaultLibrary: MTLLibrary!
    
    public static func ignite(device: MTLDevice) {

        self.device = device
        self.commandQueue = device.makeCommandQueue()
        self.defaultLibrary = device.makeDefaultLibrary()
        
        Graphics.Initialize()

        Entities.Initialize()
        
        SceneManager.initialize(Preferences.StartScene)
    }
}
