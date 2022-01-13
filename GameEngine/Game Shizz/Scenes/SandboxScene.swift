import MetalKit

class SandboxScene: Scene {
    
    var debugCamera: Camera = DebugCamera()
    var cruiser: Cruiser = Cruiser()
    var character: Character = Character()
    var imperial: ImperialSpaceShip = ImperialSpaceShip()
    
    var leftSun: Sun = Sun()
    var middleSun: Sun = Sun()
    var rightSun: Sun = Sun()
    
    var cameraDirection: Float = -1
    
    override func buildScene() {
        addCamera(camera: debugCamera)
        
        debugCamera.setPositionZ(6)
        
        leftSun.setMaterialColor(float4(0.5, 0.5, 0, 1))
        leftSun.setLightColor(color: float3(0.5, 0.5, 0))
        leftSun.setMaterialIsLit(false)
        leftSun.setPositionY(0.75)
        leftSun.setPositionX(-1)
        addLight(lightObject: leftSun)
        
        middleSun.setMaterialColor(float4(1, 1, 1, 1))
        middleSun.setLightColor(color: float3(1, 1, 1))
        middleSun.setAmbientBrightness(0.3)
        middleSun.setMaterialIsLit(false)
        middleSun.setPosition(float3(0, 0.75, 0))
        addLight(lightObject: middleSun)
        
        rightSun.setMaterialColor(float4(0, 0, 1, 1))
        rightSun.setLightColor(color: float3(0, 0, 1))
        rightSun.setMaterialIsLit(false)
        rightSun.setPosition(float3(1, 0.75, 0))
        addLight(lightObject: rightSun)
        
        imperial.setRotationX(0.3)
        imperial.setRotationY(0.3)
        imperial.setMaterialAmbient(0.05)
        addChild(imperial)
    }
    
    override func doUpdate() {
        if Mouse.IsMouseButtonPressed(button: .left) {
            rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
        
        leftSun.setPositionX(sin(GameTime.TotalGameTime) - 1)
        
        middleSun.setPositionX(sin(GameTime.TotalGameTime))
        
        rightSun.setPositionX(sin(GameTime.TotalGameTime) + 1)
        
        
        debugCamera.moveZ(GameTime.DeltaTime * cameraDirection / 2)
        if (debugCamera.getPositionZ() < 3) {
            cameraDirection = 1
        } else if (debugCamera.getPositionZ() > 9) {
            cameraDirection = -1
        }
        
        imperial.setMaterialShininess(imperial.getShininess() + Mouse.GetDWheel())
    }
}
