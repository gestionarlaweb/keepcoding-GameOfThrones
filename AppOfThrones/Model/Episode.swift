
import Foundation

// Para que sea Generico - Identifiable
// El Codable (Decodale "leer" - Encodeble "escribir" ) para el JSON
class Episode: Identifiable, Codable, Equatable, CustomStringConvertible {
    
    var id: Int
    var name: String?
    var date: String?
    var image: String?
    var episode: Int
    var season: Int
    var overview: String
    
    var description: String {
        return "S\(season )E\(episode ) -> \(name ?? "No name")"
    }
    
    init(id: Int, name: String?, date: String?, image: String?, episode: Int, season: Int, overview: String) {
        self.id = id
        self.name = name
        self.date = date
        self.image = image
        self.episode = episode
        self.season = season
        self.overview = overview
    }
    
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
}
