import MetalKit

enum RenderPipelineStateType {
    case Basic
    case Instanced
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateType, MTLRenderPipelineState> {
    
    private var renderPipelines: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    override func fillLibrary() {
        renderPipelines.updateValue(BasicRenderPipelineState(), forKey: .Basic)
        renderPipelines.updateValue(InstancedRenderPipelineState(), forKey: .Instanced)
    }
    
    override subscript(type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return renderPipelines[type]!.pipelineState
    }
}

class RenderPipelineState {
    var pipelineState: MTLRenderPipelineState!
    
    init(renderPipelineDescriptor: MTLRenderPipelineDescriptor) {
        do {
            pipelineState = try Engine.device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::\(error)")
        }
    }
}

class BasicRenderPipelineState: RenderPipelineState {
    init() {
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.label = "Basic Render Pipeline State"
        descriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        descriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        
        descriptor.vertexFunction = Graphics.shaders[.BasicVertex]
        descriptor.fragmentFunction = Graphics.shaders[.BasicFragment]
        
        descriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        super.init(renderPipelineDescriptor: descriptor)
    }
}

class InstancedRenderPipelineState: RenderPipelineState {
    init() {
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.label = "Basic Render Pipeline State"
        descriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        descriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        
        descriptor.vertexFunction = Graphics.shaders[.InstancedVertex]
        descriptor.fragmentFunction = Graphics.shaders[.BasicFragment]
        
        descriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        super.init(renderPipelineDescriptor: descriptor)
    }
}
