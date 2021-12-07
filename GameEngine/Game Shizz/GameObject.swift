import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    
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
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 1)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount:mesh.vertexCount)
    }
}
