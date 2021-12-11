import simd

enum CameraType {
    case Debug
}

protocol Camera {
    var cameraType: CameraType { get }
    var position: float3 {get set }
    func update(deltaTime: Float)
}

extension Camera {
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.translate(direction: -position)
        return viewMatrix
    }
}
