import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var cruiser: Cruiser = Cruiser()
    var character: Character = Character()
    
    var leftSun: Sun = Sun()
    var middleSun: Sun = Sun()
    var rightSun: Sun = Sun()
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(6)
        

        leftSun.setMaterialColor(color: float4(0.5, 0.5, 0, 1))
        leftSun.setLightColor(color: float3(0.5, 0.5, 0))
        leftSun.setMaterialIsLit(false)
        leftSun.setPositionY(1)
        leftSun.setPositionX(-1)
        addLight(lightObject: leftSun)
        
        middleSun.setMaterialColor(color: float4(0, 0.5, 0.5, 1))
        middleSun.setLightColor(color: float3(0, 0.5, 0.5))
        middleSun.setMaterialIsLit(false)
        middleSun.setPosition(float3(0, 1, 0))
        addLight(lightObject: middleSun)
        
        rightSun.setMaterialColor(color: float4(0, 0, 1, 1))
        rightSun.setLightColor(color: float3(0, 0, 1))
        rightSun.setMaterialIsLit(false)
        rightSun.setPosition(float3(1, 1, 0))
        addLight(lightObject: rightSun)
        
        
        cruiser.setScale(0.5)
        addChild(cruiser)
    }
    
    override func doUpdate() {
        if Mouse.IsMouseButtonPressed(button: .left) {
            rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
        
        leftSun.setPositionX(sin(GameTime.TotalGameTime))
        leftSun.setPositionZ(cos(GameTime.TotalGameTime))
        
        middleSun.setPositionY(sin(GameTime.TotalGameTime))
        middleSun.setPositionZ(cos(GameTime.TotalGameTime))
        
        rightSun.setPositionX(sin(GameTime.TotalGameTime) * -1)
        rightSun.setPositionZ(-cos(GameTime.TotalGameTime))
    }
}
