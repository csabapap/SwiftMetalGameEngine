import MetalKit

enum SceneType {
    case Sandbox
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
        }
    }
    
    static func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        currentScene.update(deltaTime: deltaTime)
        currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
