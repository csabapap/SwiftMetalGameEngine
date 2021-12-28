import MetalKit

enum RenderPipelineDescriptorType {
    case Basic
    case Instanced
}

class RenderPipelineDescriptorLibrary: Library<RenderPipelineDescriptorType, MTLRenderPipelineDescriptor> {
    
    private var renderPipelineDescriptors: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    override func fillLibrary() {
        renderPipelineDescriptors.updateValue(BasicRenderPipelineDescriptor(), forKey: .Basic)
        renderPipelineDescriptors.updateValue(InstancedRenderPipelineDescriptor(), forKey: .Instanced)
    }
    
    override subscript(type: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor? {
        return renderPipelineDescriptors[type]?.descriptor
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
        
        descriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        descriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
        
        descriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
    }
}

struct InstancedRenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipeline Descriptor"
    
    var descriptor: MTLRenderPipelineDescriptor!
    init() {
        descriptor = MTLRenderPipelineDescriptor()
        descriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        descriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        
        descriptor.vertexFunction = Graphics.VertexShaders[.Instanced]
        descriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
        
        descriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
    }
}
