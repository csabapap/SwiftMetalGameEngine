import MetalKit

enum RenderPipelineStateType {
    case Basic
}

class RenderPipelineStateLibrary {
    
    private static var renderPipelines: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    static func initialize() {
        createDefaultRenderPipelineState()
    }
    
    static func getRenderPipelineState(_ type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return renderPipelines[type]!.pipelineState
    }
 
    private static func createDefaultRenderPipelineState() {
        renderPipelines.updateValue(BasicRenderPipelineState(), forKey: .Basic)
    }
}

protocol RenderPipelineState {
    var name: String {get}
    var pipelineState: MTLRenderPipelineState! { get }
}

struct BasicRenderPipelineState: RenderPipelineState {
    var name: String = "Basic Render Pipeline State"
    var pipelineState: MTLRenderPipelineState!
    init() {
        do {
            pipelineState = try Engine.device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.getRenderPipelineDescriptor(.Basic))
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__\(name)__::\(error)")
        }
    }
}
