import MetalKit

enum VertexDescriptorType {
    case Basic
}

class VertexDescriptorLibrary {
    private static var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    public static func initialize() {
        createDefaultVertexDescriptor()
    }
    
    private static func createDefaultVertexDescriptor() {
        vertexDescriptors.updateValue(BasicVertexDiscriptor(), forKey: .Basic)
    }
    
    public static func getVertexDescriptor(_ type: VertexDescriptorType) -> MTLVertexDescriptor {
        return vertexDescriptors[type]!.descriptor
    }
}

protocol VertexDescriptor {
    var name: String { get }
    var descriptor: MTLVertexDescriptor! { get }
}

public struct BasicVertexDiscriptor: VertexDescriptor {
    var name: String = "Basic Vertex Discriptor"
    
    var descriptor: MTLVertexDescriptor!
    init() {
        descriptor = MTLVertexDescriptor()
        descriptor.attributes[0].format = .float3
        descriptor.attributes[0].bufferIndex = 0
        descriptor.attributes[0].offset = 0
        
        descriptor.attributes[1].format = .float4
        descriptor.attributes[1].bufferIndex = 0
        descriptor.attributes[1].offset = float3.stride
        
        descriptor.layouts[0].stride = Vertex.stride
    }
}
