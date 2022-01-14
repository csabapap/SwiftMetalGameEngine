import MetalKit

enum SceneType {
    case Sandbox
    case CubesScene
    case PartyParotScene
    case PlaygroundScene
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
        case .PartyParotScene:
            currentScene = PartyParotScene()
        case .PlaygroundScene:
            currentScene = PlaygroundScene()
        }
    }
    
    static func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        GameTime.update(deltaTime: deltaTime)
        currentScene.updateCameras(deltatTime: deltaTime)
        currentScene.update()
        currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
