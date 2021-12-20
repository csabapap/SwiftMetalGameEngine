import MetalKit

class ColorUtils {
    static func randomColor() -> float4 {
        return float4(
            Float.randomZeroToOne,
            Float.randomZeroToOne,
            Float.randomZeroToOne, 1.0)
    }
}
