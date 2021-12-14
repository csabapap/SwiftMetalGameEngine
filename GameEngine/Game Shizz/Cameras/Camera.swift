import simd

enum CameraType {
    case Debug
}

protocol CameraUpdateListener {
    func updateCamera(deltaTime: Float)
}

protocol Camera {
    var cameraType: CameraType { get }
    var position: float3 {get set }
    var projectionMatrix: matrix_float4x4 { get }
    func update(deltaTime: Float)
    var delegate: CameraUpdateListener? { get set }
}

extension Camera {
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.translate(direction: -position)
        return viewMatrix
    }
}
