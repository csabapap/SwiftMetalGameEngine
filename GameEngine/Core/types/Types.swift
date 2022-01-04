import simd

protocol sizeable {}

extension sizeable {
    static var size: Int {
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int) -> Int {
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int) -> Int {
        return MemoryLayout<Self>.stride * count
    }
}

extension Float: sizeable {
    func randomFromZeroToOne() -> Float {
        return Float.random(in: 0...1)
    }
}

extension float2: sizeable { }
extension float3: sizeable { }
extension float4: sizeable { }

struct Vertex: sizeable {
    var position: float3
    var color: float4
    var textureCoordinates: float2
};

struct ModelConstants: sizeable {
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants: sizeable {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    var gameTime: Float = 0
}

struct Material: sizeable {
    var color: float4
    var useMaterialColor: Bool
    var useTexture: Bool
    
    init() {
        color = float4(0.9, 0.3, 0.4, 1.0)
        useMaterialColor = false
        useTexture = false
    }
}

struct LightData: sizeable {
    var position: float3 = float3(0,0,0)
}
