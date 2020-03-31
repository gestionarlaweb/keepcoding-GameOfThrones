//
//  DataController.swift

// SINGLETON

import Foundation

protocol FavoriteDelegate {
    func didFavoriteChanged()
}

protocol ReviewDelegate {
    func didReviewChanged()
}

// GENERICOS
// Ver los Modelos - Identifiable - obtener el ID 
protocol Identifiable {
    var id: Int { get }
}

// Se puede instanciar desde cualquier sítio
class DataController {
    // "Patrón singleton"
    // private donde privo que se pueda inicializar desde fuera de aquí
    
    // AÑADIR O QUITAR ENTEROS A LOS ARRAY
    // Objeto responsable de tener los datos de favoritos de actores
    private var favorite: [Int] = []
    // Objeto responsable de tener los datos de todas las puntuaciones de episodios
    private var rating: [Rating] = []
    
    static let shared = DataController()
    private init(){}
    
    // MARK: - Favorite

    // GENERICOS Permite tipos y funciones reutilizables - Video 6 1h25'
    // EXISTE FAVORITO en EPISODIO O CAST
    // T: Te voy a pasar una clase estructura que va a cumplir "T" en este caso un protocolo Identifiable, el de los modelos Cast y Episode
    func isFavorite<T: Identifiable>(_ value: T) -> Bool {
        return favorite.contains(value.id) // Es un elemento que va a tener si o si un ID
    }
    
    // AÑADE FAVORITO en EPISODIO O CAST
    func addFavorite<T: Identifiable>(_ value: T) {
        if self.isFavorite(value) == false {
            favorite.append(value.id)
        }
    }
    
    // ELIMINA FAVORITO en EPISODIO O CAST
    func removeFavorite<T: Identifiable>(_ value: T) {
        if let index = favorite.firstIndex(of: value.id) {
            favorite.remove(at: index)
        }
    }
    
    // Elimina todos los favoritos
    func removeAllFavorite(){
        favorite.removeAll()
    }
    // Elimina todos los reviews
    func removeAllRatings(){
        rating.removeAll()
    }
 
    // MARK: - Rating
    
    func rateEpisode(_ episode: Episode, value: Double) {
        if self.ratingForEpisode(episode) == nil {
            let value = Rating.init(id: episode.id, rate: .rated(value: value))
            rating.append(value)
        }
    }
    
    func removeRateEpisode(_ episode: Episode) {
        if let index = self.rating.firstIndex(where: { (rating) -> Bool in
                return episode.id == rating.id
        }) {
            self.rating.remove(at: index)
        }
    }
    
    func ratingForEpisode(_ episode: Episode) -> Rating? {
        let filtered = rating.filter { (rating) -> Bool in
            return rating.id == episode.id
        }
        return filtered.first
    }
}
