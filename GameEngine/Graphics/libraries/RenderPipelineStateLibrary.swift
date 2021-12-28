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
    
    override subscript(type: RenderPipelineStateType) -> MTLRenderPipelineState? {
        return renderPipelines[type]?.pipelineState
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
            pipelineState = try Engine.device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.Basic]!)
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__\(name)__::\(error)")
        }
    }
}

struct InstancedRenderPipelineState: RenderPipelineState {
    var name: String = "Basic Render Pipeline State"
    var pipelineState: MTLRenderPipelineState!
    init() {
        do {
            pipelineState = try Engine.device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.Instanced]!)
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__\(name)__::\(error)")
        }
    }
}
