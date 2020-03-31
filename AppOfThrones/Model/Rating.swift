
import Foundation

enum Rate {
    // caso de que no este puntuado
    case unrated
    // caso de que si este puntuado y tenga un valor Double
    case rated(value: Double)
}

struct Rating: Equatable, CustomStringConvertible {
    // Id del episodio para saber que episodio es
    var id: Int
    // la puntuación del enumerador de arriva. var rate será unrated o rated(value:double)
    var rate: Rate
    var description: String {
        var str = ""
        switch rate {
        case .unrated:
            str = "Unrated"
        case .rated(let value):
            str = "Rated: \(value)"
        }
        return "\(id) -> \(str)"
    }
    
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        return lhs.id == rhs.id
    }
    
}

// La puntuación del episodio la vamos a guardar en el Singleton (DataController)
