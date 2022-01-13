import MetalKit

enum ShaderTypes {
    // Vertex
    case BasicVertex
    case InstancedVertex
    
    // Fragment
    case BasicFragment
}

class ShaderLibrary: Library<ShaderTypes, MTLFunction> {
    
    private var library: [ShaderTypes: Shader] = [:]
    
    override func fillLibrary() {
        // vertex shaders
        library.updateValue(Shader(name: "Basic Vertex Shader",functionName: "basic_vertex_shader"),
                                  forKey: .BasicVertex)
        
        library.updateValue(Shader(name: "Instanced Vertex Shader", functionName: "instanced_vertex_shader"),
                                  forKey: .InstancedVertex)
        
        // fragment shaders
        library.updateValue(Shader(name: "Basic Fragment Shader", functionName: "basic_fragment_shader"),
                             forKey: .BasicFragment)
    }
    
    override subscript(type: ShaderTypes) -> MTLFunction {
        return (library[type]?.function)!
    }
}

class Shader {
    var function: MTLFunction!
    init(name: String, functionName: String) {
        self.function = Engine.defaultLibrary.makeFunction(name: functionName)
        self.function.label = name
    }
}
