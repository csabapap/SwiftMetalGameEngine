import MetalKit

enum TextureTypes {
    case None
    case PartyPirateParot
    case Cruiser
    case Imperial
    
    case MetalPlateDiffuse
    case MetalPlateNormal
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    
    private var library: [TextureTypes: Texture] = [:]
    
    override func fillLibrary() {
        library.updateValue(Texture("PartyPirateParot"), forKey: .PartyPirateParot)
        library.updateValue(Texture("cruiser", ext: "bmp", origin: .bottomLeft), forKey: .Cruiser)
        library.updateValue(Texture("Imperial_Red", ext: "png", origin: .bottomLeft), forKey: .Imperial)
        
        library.updateValue(Texture("metal_plate_diff", ext: "png"), forKey: .MetalPlateDiffuse)
        library.updateValue(Texture("metal_plate_nor", ext: "png"), forKey: .MetalPlateNormal)
    }
    
    override subscript(type: TextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
}

class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "png", origin: MTKTextureLoader.Origin = .topLeft) {
        let textureLoader = TextureLoader(textureName, ext, origin)
        let texture = textureLoader.loadTextureFromBundle()
        setTexture(texture)
    }
    
    func setTexture(_ texture: MTLTexture) {
        self.texture = texture
    }
}

enum TextureOrigin {
    case TopLeft
    case BottomLeft
}

class TextureLoader {
    
    let textureName: String!
    let textureExt: String!
    var textureOrigin: MTKTextureLoader.Origin
    
    init(_ textureName: String, _ textureExt: String, _ origin: MTKTextureLoader.Origin = .topLeft) {
        self.textureName = textureName
        self.textureExt = textureExt
        textureOrigin = origin
    }
    
    func loadTextureFromBundle() -> MTLTexture {
        
        var result: MTLTexture!
        
        if let url = Bundle.main.url(forResource: textureName, withExtension: textureExt) {
            let textureLoader = MTKTextureLoader(device: Engine.device)
            
            let options: [MTKTextureLoader.Option: Any] = [
                MTKTextureLoader.Option.origin: textureOrigin,
                MTKTextureLoader.Option.generateMipmaps: true
            ]
            
            do {
                result = try textureLoader.newTexture(URL: url, options: options)
                result.label = textureName
            } catch let error as NSError {
                print("ERROR::CREATING::TEXTURE::__\(textureName!)__::\(error)")
            }
        } else {
            print("ERROR::CREATING::TEXTURE::__\(textureName!) does not exist")
        }
        
        return result
    }
}
