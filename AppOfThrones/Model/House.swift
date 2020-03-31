
import Foundation

// El Codable (Decodale "leer" - Encodeble "escribir" ) para el JSON
class House: Codable, Equatable, CustomStringConvertible {
    
    var imageName: String?
    var name: String?
    var words: String?
    var seat: String?
    
    var description: String {
        return "\(name ?? "No name") -> \(words ?? "No words")"
    }
    
    init(imageName: String?, name: String?, words: String?, seat: String?) {
        self.imageName = imageName
        self.name  = name
        self.words = words
        self.seat  = seat
    }

    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.name == rhs.name
    }
    
}
