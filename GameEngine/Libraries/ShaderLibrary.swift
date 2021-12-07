import MetalKit

enum VertexShaderType {
    case Basic
}

enum FragmentShaderType {
    case Basic
}

class ShaderLibrary {
    
    public static var defaultLibrary: MTLLibrary!
    
    private static var vertexShaders: [VertexShaderType:Shader] = [:]
    private static var fragmentShaders: [FragmentShaderType:Shader] = [:]
    
    public static func initialize() {
        defaultLibrary = Engine.device.makeDefaultLibrary()
        
        createDefaultShaders()
    }
    
    public static func createDefaultShaders() {
        // vertexShaders
        vertexShaders.updateValue(BasicVertexShader(), forKey: .Basic)
        
        // fragment shaders
        fragmentShaders.updateValue(BasicFragmentShader(), forKey: .Basic)
    }
    
    public static func getVertexFunction(_ type: VertexShaderType) -> MTLFunction {
        return vertexShaders[type]!.function
    }
    
    public static func getFragmentFunction(_ type: FragmentShaderType) -> MTLFunction {
        return fragmentShaders[type]!.function
    }
}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction! { get }
}

class BasicVertexShader: Shader {
    var name: String = "Basic Vertex Shader"
    
    var functionName: String = "basic_vertex_shader"
    
    var function: MTLFunction!
    init() {
        function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name
    }
}

class BasicFragmentShader: Shader {
    var name: String = "Basic Fragment Shader"
    
    var functionName: String = "basic_fragment_shader"
    
    var function: MTLFunction!
    init() {
        function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function.label = name
    }
}
