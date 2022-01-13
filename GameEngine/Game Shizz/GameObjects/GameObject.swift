import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    private var textureType: TextureTypes = .None
    
    var mesh: Mesh!
    
    var deltaPosition: Float = 0
    
    init(meshType: MeshType, name: String) {
        mesh = Entities.Meshes[meshType]
        super.init(name: name)
    }
    
    override func update() {
        modelConstants.modelMatrix = self.modelMatrix
        super.update()
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
    func setMaterialColor(_ color: float4) {
        material.color = color
        material.useMaterialColor = true
        material.useTexture = false
    }
    
    public func setMaterialColor(_ r: Float,_ g: Float,_ b: Float,_ a: Float) {
        setMaterialColor(float4(r,g,b,a))
    }
    
    func setTexture(textureType: TextureTypes) {
        self.textureType = textureType
        self.material.useTexture = true
        self.material.useMaterialColor = false
    }
    
    // Is Lit
    public func setMaterialIsLit(_ isLit: Bool) { self.material.isLit = isLit }
    public func getMaterialIsLit()->Bool { return self.material.isLit }
    
    // Ambient
    public func setMaterialAmbient(_ ambient: float3) { self.material.ambient = ambient }
    public func setMaterialAmbient(_ r: Float,_ g: Float,_ b: Float) { setMaterialAmbient(float3(r,g,b)) }
    public func setMaterialAmbient(_ ambient: Float) { self.material.ambient = float3(ambient, ambient, ambient) }
    public func addMaterialAmbient(_ value: Float) { self.material.ambient += value }
    public func getMaterialAmbient()->float3 { return self.material.ambient }
    
    // Diffuse
    public func setMaterialDiffuse(_ diffuse: float3) { self.material.diffuse = diffuse }
    public func setMaterialDiffuse(_ r: Float,_ g: Float,_ b: Float) { setMaterialDiffuse(float3(r,g,b)) }
    public func setMaterialDiffuse(_ diffuse: Float) { self.material.diffuse = float3(diffuse, diffuse, diffuse) }
    public func addMaterialDiffuse(_ value: Float) { self.material.diffuse += value }
    public func getMaterialDiffuse()->float3 { return self.material.diffuse }
    
    // Specular
    public func setMaterialSpecular(_ specular: float3) { self.material.specular = specular }
    public func setMaterialSpecular(_ r: Float,_ g: Float,_ b: Float) { setMaterialSpecular(float3(r,g,b)) }
    public func setMaterialSpecular(_ specular: Float) { self.material.specular = float3(specular, specular, specular) }
    public func addMaterialSpecular(_ value: Float) { self.material.specular += value }
    public func getMaterialSpecular()->float3 { return self.material.specular }
    
    // Shininess
    public func setMaterialShininess(_ shininess: Float) { self.material.shininess = shininess }
    public func getShininess()->Float { return self.material.shininess }
}
