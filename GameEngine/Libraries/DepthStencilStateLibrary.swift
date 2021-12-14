import MetalKit

enum DepthStencilStateTypes {
    case Less
}

class DepthStencilStateLibrary {
    
    private static var depthStencils: [DepthStencilStateTypes:DepthStencilState] = [:]
    
    static func initialize() {
        createDefaultDepthStencilState()
    }
    
    private static func createDefaultDepthStencilState() {
        depthStencils.updateValue(LessDepthStencilState(), forKey: .Less)
    }
    
    static func getDepthStencilState(_ type: DepthStencilStateTypes) -> MTLDepthStencilState {
        return depthStencils[type]!.depthStencilState
    }
    
}

protocol DepthStencilState {
    var depthStencilState: MTLDepthStencilState! { get }
}

class LessDepthStencilState: DepthStencilState {
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilStateDescriptor = MTLDepthStencilDescriptor()
        depthStencilStateDescriptor.isDepthWriteEnabled = true
        depthStencilStateDescriptor.depthCompareFunction = .less
        depthStencilState = Engine.device.makeDepthStencilState(descriptor: depthStencilStateDescriptor)
    }
    
    
}
