import MetalKit

enum MeshType {
    case TriangleCustom
    case QuadCustom
}

class MeshLibrary {
    private static var meshes: [MeshType: Mesh] = [:]
    
    static func initialize () {
        createDefaultMesh()
    }
    
    private static func createDefaultMesh() {
        meshes.updateValue(TriangleCustomMesh(), forKey: .TriangleCustom)
        meshes.updateValue(QuadCustomMesh(), forKey: .QuadCustom)
    }
    
    static func getMesh(_ meshType: MeshType) -> Mesh {
        return meshes[meshType]!
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}

class CustomMesh: Mesh {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int! {
        return vertices.count
    }
    
    init() {
        createVertices()
        createBuffers()
    }
    
    func createVertices() { }

    func createBuffers() {
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
}

class TriangleCustomMesh: CustomMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: float3(0, 1, 0), color: float4(1, 0, 0, 1)),
            Vertex(position: float3(-1, -1, 0), color: float4(0, 1, 0, 1)),
            Vertex(position: float3(1, -1, 0), color: float4(0, 0, 1, 1))
        ]
    }
}

class QuadCustomMesh: CustomMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: float3(1, 1, 0), color: float4(1, 0, 0, 1)),
            Vertex(position: float3(-1, 1, 0), color: float4(0, 1, 0, 1)),
            Vertex(position: float3(-1, -1, 0), color: float4(0, 0, 1, 1)),
            
            Vertex(position: float3(1, 1, 0), color: float4(1, 0, 0, 1)),
            Vertex(position: float3(-1, -1, 0), color: float4(0, 0, 1, 1)),
            Vertex(position: float3(1, -1, 0), color: float4(0, 1, 0, 1))
        ]
    }
}
