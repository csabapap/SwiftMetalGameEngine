import MetalKit

enum RenderPipelineDescriptorType {
    case Basic
}

class RenderPipelineDescriptorLibrary {
    
    private static var renderPipelineDescriptors: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    static func initialize() {
        createDefaultRenderPipelineDescriptor()
    }
    
    private static func createDefaultRenderPipelineDescriptor() {
        renderPipelineDescriptors.updateValue(BasicRenderPipelineDescriptor(), forKey: .Basic)
    }
    
    static func getRenderPipelineDescriptor(_ type: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptors[type]!.descriptor
    }
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var descriptor: MTLRenderPipelineDescriptor! { get }
}

struct BasicRenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipeline Descriptor"
    
    var descriptor: MTLRenderPipelineDescriptor!
    init() {
        descriptor = MTLRenderPipelineDescriptor()
        descriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        descriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        
        descriptor.vertexFunction = ShaderLibrary.getVertexFunction(.Basic)
        descriptor.fragmentFunction = ShaderLibrary.getFragmentFunction(.Basic)
        
        descriptor.vertexDescriptor = VertexDescriptorLibrary.getVertexDescriptor(.Basic)
    }
}
