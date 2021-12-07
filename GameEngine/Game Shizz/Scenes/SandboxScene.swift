import MetalKit

class SandboxScene: Scene {
    
    var player = Player()
    
    override func buildScene() {
        for y in -5..<5  {
            for x in -5..<5 {
                let player = Player()
                player.position.y = (Float(y) + 0.5) / 5
                player.position.x = (Float(x) + 0.5) / 5
                player.scale = float3(0.1)
                addChild(player)
            }
        }
    }
    
//    override func update(deltaTime: Float) {
//
//    }
}
