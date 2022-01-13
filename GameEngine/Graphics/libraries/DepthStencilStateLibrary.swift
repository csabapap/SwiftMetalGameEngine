import MetalKit

enum DepthStencilStateTypes {
    case Less
}

class DepthStencilStateLibrary: Library<DepthStencilStateTypes, MTLDepthStencilState> {
    
    private var _library: [DepthStencilStateTypes: DepthStencilState] = [:]
        
        override func fillLibrary() {
            _library.updateValue(LessDepthStencilState(), forKey: .Less)
        }
        
        override subscript(_ type: DepthStencilStateTypes)->MTLDepthStencilState{
            return _library[type]!.depthStencilState
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
