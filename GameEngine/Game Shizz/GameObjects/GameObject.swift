import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    private var textureType: TextureTypes = .None
    
    var mesh: Mesh!
    
    var deltaPosition: Float = 0
    
    init(meshType: MeshType) {
        mesh = Entities.Meshes[meshType]
    }
    
    override func update() {
        updateModelConstants()
        super.update()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        // vertext buffers
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        // fragment buffers
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        if material.useTexture {
            renderCommandEncoder.setFragmentTexture(Entities.Textures[textureType], index: 0)
        }
        
        mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension GameObject {
    func setMaterialColor(color: float4) {
        material.color = color
        material.useMaterialColor = true
        material.useTexture = false
    }
    
    func setTexture(textureType: TextureTypes) {
        self.textureType = textureType
        self.material.useTexture = true
        self.material.useMaterialColor = false
    }
    
    func setMaterialAmbient(_ ambient: float3) {
        material.ambient = ambient
    }
    
    func setMaterialAmbient(_ ambient: Float) {
        material.ambient = float3(ambient, ambient, ambient)
    }
    
    func addMaterialAmbient(_ value: Float) {
        material.ambient += value
    }
    
    func getMaterialAmbient() -> float3 {
        return material.ambient
    }
    
    func setMaterialDiffuse(_ diffuse: float3) {
        material.diffuse = diffuse
        
    }
    func setMaterialDiffuse(_ diffuse: Float) {
        material.diffuse = float3(diffuse, diffuse, diffuse)
    }
    func addMaterialDiffuse(_ value: Float) {
        material.diffuse += value
        
    }
    func getMaterialDiffuse() -> float3 {
        return material.diffuse
    }
    
    // Specular
    func setMaterialSpecular(_ specular: float3) {
        material.specular = specular
        
    }
    func setMaterialSpecular(_ specular: Float) {
        material.specular = float3(specular, specular, specular)
    }
    func addMaterialSpecular(_ value: Float) {
        material.specular += value
        
    }
    func getMaterialSpecular() -> float3 {
        return material.specular
    }
    
    func setMaterialIsLit(_ isLit: Bool) {
        material.isLit = isLit
    }
    
    func isMaterialLit() -> Bool {
        return material.isLit
    }
    
    func setMaterialShininess(_ value: Float) {
        material.shininess = value
    }
    
    func getMaterialShininess() -> Float {
        return material.shininess
    }
}
