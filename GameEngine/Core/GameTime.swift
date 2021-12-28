import MetalKit

class GameTime {
    
    private static var _deltaTime: Float = 0.0
    private static var _totalTime: Float = 0.0
    
    
    static func update(deltaTime: Float) {
        _deltaTime = deltaTime
        _totalTime += deltaTime
    }
}

extension GameTime {
    static var TotalGameTime: Float {
        return _totalTime
    }
    
    static var DeltaTime: Float {
        return _deltaTime
    }
}
