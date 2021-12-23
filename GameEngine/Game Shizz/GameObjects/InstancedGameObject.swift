import MetalKit

class InstancedGameObject: Node {
    
    private var mesh: Mesh!
    
    var material = Material()
    
    internal var nodes: [Node] = []
    
    private var modelConstantsBuffer: MTLBuffer!
    
    init(meshType: MeshType, instanceCount: Int) {
        super.init()
        mesh = MeshLibrary.getMesh(meshType)
        mesh.setInstanceCount(instanceCount)
        self.generateInstances(instanceCount: instanceCount)
        self.createBuffers(instanceCount: instanceCount)
        self.name = "Instanced Game Object"
    }
    
    func generateInstances(instanceCount: Int) {
        for _ in 0..<instanceCount {
            let node = Node()
            nodes.append(node)
        }
    }
    
    func createBuffers(instanceCount: Int) {
        modelConstantsBuffer = Engine.device.makeBuffer(length: ModelConstants.stride(instanceCount), options: [])
    }
    
    private func updateModelConstantsBuffer() {
        var pointer = modelConstantsBuffer.contents().bindMemory(to: ModelConstants.self, capacity: nodes.count)
        
        for node in nodes {
            pointer.pointee.modelMatrix = matrix_multiply(self.modelMatrix, node.modelMatrix)
            pointer = pointer.advanced(by: 1)
        }
    }
    
    override func update(deltaTime: Float) {
        
        updateModelConstantsBuffer()
        
        super.update(deltaTime: deltaTime)
    }
}

extension InstancedGameObject: Renderable {
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Instanced))
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.getDepthStencilState(.Less))
        
        // vertext buffers
        
        renderCommandEncoder.setVertexBuffer(modelConstantsBuffer, offset: 0, index: 2)
        
        // fragment buffers
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension InstancedGameObject {
    func setColor(color: float4) {
        material.color = color
        material.isActive = true
    }
}
