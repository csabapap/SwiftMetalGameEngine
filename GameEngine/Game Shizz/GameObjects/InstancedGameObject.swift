import MetalKit

class InstancedGameObject: Node {
    
    private var mesh: Mesh!
    
    var material = Material()
    
    internal var nodes: [Node] = []
    
    private var modelConstantsBuffer: MTLBuffer!
    
    init(meshType: MeshType, instanceCount: Int) {
        super.init()
        mesh = Entities.Meshes[meshType]
        mesh.setInstanceCount(instanceCount)
        self.generateInstances(instanceCount: instanceCount)
        self.createBuffers(instanceCount: instanceCount)
        setName("Instanced Game Object")
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
    
    override func update() {
        
        updateModelConstantsBuffer()
        
        super.update()
    }
}

extension InstancedGameObject: Renderable {
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic]!)
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
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
