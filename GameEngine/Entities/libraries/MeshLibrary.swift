import MetalKit

enum MeshType {
    case TriangleCustom
    case QuadCustom
    case CubeCustom
    
    case None
    case Cruiser
    case Character
    case Sphere
    case Imperial
}

class MeshLibrary: Library<MeshType, Mesh> {
    private var meshes: [MeshType: Mesh] = [:]
    
    override func fillLibrary() {
        meshes.updateValue(TriangleCustomMesh(), forKey: .TriangleCustom)
        meshes.updateValue(QuadCustomMesh(), forKey: .QuadCustom)
        meshes.updateValue(CubeCustomMesh(), forKey: .CubeCustom)
        meshes.updateValue(NoMesh(), forKey: .None)
        meshes.updateValue(ModelMesh(modelName: "cruiser"), forKey: .Cruiser)
        meshes.updateValue(ModelMesh(modelName: "Character"), forKey: .Character)
        meshes.updateValue(ModelMesh(modelName: "sphere"), forKey: .Sphere)
        meshes.updateValue(ModelMesh(modelName: "Imperial"), forKey: .Imperial)
    }

    override subscript(type: MeshType) -> Mesh? {
        return meshes[type]
    }
}

protocol Mesh {
    func setInstanceCount(_ count: Int)
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

class NoMesh: Mesh {
    func setInstanceCount(_ count: Int) { }
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) { }
}

class ModelMesh: Mesh {
    
    private var meshes: [Any]!
    private var instanceCount: Int = 1
    
    init(modelName: String) {
        loadModel(modelName: modelName)
    }
    
    func loadModel(modelName: String) {
        guard let assetUrl = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
            fatalError("Asset \(modelName) does not exist")
        }
        
        let descriptor = MTKModelIOVertexDescriptorFromMetal(Graphics.VertexDescriptors[.Basic])
        (descriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
        (descriptor.attributes[1] as! MDLVertexAttribute).name = MDLVertexAttributeColor
        (descriptor.attributes[2] as! MDLVertexAttribute).name = MDLVertexAttributeTextureCoordinate
        (descriptor.attributes[3] as! MDLVertexAttribute).name = MDLVertexAttributeNormal
        
        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
        let asset: MDLAsset = MDLAsset(url: assetUrl,
                                       vertexDescriptor: descriptor,
                                       bufferAllocator: bufferAllocator)
        do {
            self.meshes = try MTKMesh.newMeshes(asset: asset, device: Engine.device).metalKitMeshes
        } catch let error as NSError {
            print("ERROR::LOADING_MESH::__\(modelName)__::\(error)")
        }
    }
 
    func setInstanceCount(_ count: Int) {
        instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        guard let mtkMeshes = self.meshes as? [MTKMesh] else { return }
        
        for mesh in mtkMeshes {
            for vertexBuffer in mesh.vertexBuffers {
                renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
                for submesh in mesh.submeshes {
                    renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                               indexCount: submesh.indexCount,
                                                               indexType: submesh.indexType,
                                                               indexBuffer: submesh.indexBuffer.buffer,
                                                               indexBufferOffset: submesh.indexBuffer.offset,
                                                               instanceCount: instanceCount)
                }
            }
        }
    }
}

class CustomMesh: Mesh {
    
    var vertices: [Vertex] = []
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var vertexCount: Int! {
        return vertices.count
    }
    var indexCount: Int {
        return indices.count
    }
    
    var instanceCount: Int = 1
    
    init() {
        createMesh()
        createBuffers()
    }
    
    func createMesh() { }

    func createBuffers() {
        if vertexCount > 0 {
            vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        }
        
        if indexCount > 0 {
            indexBuffer = Engine.device.makeBuffer(bytes: indices, length: UInt32.stride(indices.count), options: [])
        }
    }
    
    func addVertex(position: float3,
                   color: float4 = float4(1,0,1,1),
                   textureCoordinate: float2 = float2(repeating: 0),
                   normal: float3 = float3(0, 1, 0)
    ) {
        vertices.append(Vertex(
            position: position,
            color: color,
            textureCoordinates: textureCoordinate,
            normal: normal))
    }
    
    func addIndices(_ indexes: [UInt32]) {
        self.indices.append(contentsOf: indexes)
    }
    
    func setInstanceCount(_ count: Int) {
        self.instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        if vertexCount <= 0 { return }
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        if indexCount > 0 {
            renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                       indexCount: indexCount,
                                                       indexType: .uint32,
                                                       indexBuffer: indexBuffer,
                                                       indexBufferOffset: 0,
                                                       instanceCount: instanceCount)
        } else {
            renderCommandEncoder.drawPrimitives(type: .triangle,
                                                vertexStart: 0,
                                                vertexCount: vertexCount,
                                                instanceCount: instanceCount)
        }
    }
}

class TriangleCustomMesh: CustomMesh {
    override func createMesh() {
        addVertex(position: float3(0, 1, 0), color: float4(1, 0, 0, 1))
        addVertex(position: float3(-1, -1, 0), color: float4(0, 1, 0, 1))
        addVertex(position: float3(1, -1, 0), color: float4(0, 0, 1, 1))
    }
}

class QuadCustomMesh: CustomMesh {
    override func createMesh() {
        addVertex(position: float3(1, 1, 0), color: float4(1, 0, 0, 1), textureCoordinate: float2(1, 0), normal: float3(0, 0, 1))
        addVertex(position: float3(-1, 1, 0), color: float4(0, 1, 0, 1), textureCoordinate: float2(0, 0), normal: float3(0, 0, 1))
        addVertex(position: float3(-1, -1, 0), color: float4(0, 0, 1, 1), textureCoordinate: float2(0, 1), normal: float3(0, 0, 1))
        addVertex(position: float3(1, -1, 0), color: float4(1, 0, 1, 1), textureCoordinate: float2(1, 1), normal: float3(0, 0, 1))
        
        addIndices([0, 1, 2,    0, 2, 3])
    }
}

class CubeCustomMesh: CustomMesh {
    override func createMesh() {
        //Left
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(1.0, 0.0, 1.0, 1.0))
            
        //RIGHT
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.5, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 1.0, 1.0))
    
        //TOP
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.5, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0))
        
        //BOTTOM
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0))
            
        //BACK
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //FRONT
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(0.5, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0))
        
    }
}
