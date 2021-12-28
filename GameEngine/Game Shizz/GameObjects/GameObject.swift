import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    
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
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic]!)
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        // vertext buffers
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        // fragment buffers
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension GameObject {
    func setColor(color: float4) {
        material.color = color
        material.isActive = true
    }
}
