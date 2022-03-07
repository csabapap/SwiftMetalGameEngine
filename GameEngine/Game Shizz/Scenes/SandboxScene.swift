import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var sun = Sun()
    var quad = Quad()
    
    var cameraDirection: Float = -1
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(3)
        addCamera(camera: debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setAmbientIntensity(0.04)
        addLight(lightObject: sun)
        
        quad.useBaseColorTexture(textureType: .MetalPlateDiffuse)
        quad.useNormalMapTexture(.MetalPlateNormal)
        
//        quad.moveY(-0.5)
        addChild(quad)
    }
    
    override func doUpdate() {
        if Mouse.IsMouseButtonPressed(button: .left) {
            rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}
