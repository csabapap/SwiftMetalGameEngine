import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    
    var mesh: Mesh
    
    var deltaPosition: Float = 0
    
    init(meshType: MeshType) {
        mesh = MeshLibrary.getMesh(meshType)
    }
    
    override func update(deltaTime: Float) {
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Basic))
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.getDepthStencilState(.Less))
        
        // vertext buffers
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        // fragment buffers
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount:mesh.vertexCount)
    }
}

extension GameObject {
    func setColor(color: float4) {
        material.color = color
        material.isActive = true
    }
}
