import MetalKit

enum SceneType {
    case Sandbox
    case CubesScene
}

class SceneManager {
    private static var currentScene: Scene!
    
    public static func initialize(_ sceneType: SceneType) {
        createScene(sceneType)
    }
    
    static func createScene(_ sceneType: SceneType) {
        switch sceneType {
        case .Sandbox:
            currentScene = SandboxScene()
        case .CubesScene:
            currentScene = CubesScene()
        }
    }
    
    static func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        currentScene.updateCameras(deltatTime: deltaTime)
        currentScene.update(deltaTime: deltaTime)
        currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
