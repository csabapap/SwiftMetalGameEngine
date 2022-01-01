import MetalKit

enum VertexDescriptorType {
    case Basic
}

class VertexDescriptorLibrary: Library<VertexDescriptorType, MTLVertexDescriptor> {
    private var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    override func fillLibrary() {
        vertexDescriptors.updateValue(BasicVertexDescriptor(), forKey: .Basic)
    }
    
    override subscript(_ type: VertexDescriptorType)->MTLVertexDescriptor {
        return vertexDescriptors[type]!.descriptor
    }
}

protocol VertexDescriptor {
    var name: String { get }
    var descriptor: MTLVertexDescriptor! { get }
}

public struct BasicVertexDescriptor: VertexDescriptor {
    var name: String = "Basic Vertex Discriptor"
    
    var descriptor: MTLVertexDescriptor!
    init() {
        descriptor = MTLVertexDescriptor()
        descriptor.attributes[0].format = .float3
        descriptor.attributes[0].bufferIndex = 0
        descriptor.attributes[0].offset = 0
        
        descriptor.attributes[1].format = .float4
        descriptor.attributes[1].bufferIndex = 0
        descriptor.attributes[1].offset = float3.size
        
        descriptor.attributes[2].format = .float2
        descriptor.attributes[2].bufferIndex = 0
        descriptor.attributes[2].offset = float3.size + float4.size
        
        descriptor.layouts[0].stride = Vertex.stride
    }
}
