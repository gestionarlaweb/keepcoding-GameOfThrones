//
//  CastTableViewCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

protocol CastTableViewCellDelegate: class {
    func didFavoriteChanged()
}

class CastTableViewCell: UITableViewCell {
    
    private weak var cast: Cast?
    weak var delegate: CastTableViewCellDelegate?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var episodes: UILabel!
    @IBOutlet weak var heart: UIImageView!
    
    override func awakeFromNib() {
        avatar.layer.cornerRadius = 8
        avatar.layer.borderColor  = UIColor.white.withAlphaComponent(0.2).cgColor
        avatar.layer.borderWidth  = 1.0
    }
    
    
    func setCast(_ cast: Cast) {
        self.cast = cast
        avatar.image = cast.avatar == nil ? nil : UIImage.init(named: cast.avatar!)
        name.text   = cast.fullname
        role.text   = cast.role
        episodes.text = "\(cast.episodes ?? 0) Episodes"
        
        // Si si existe el ? favorito si no :
        let heartImage = DataController.shared.isFavorite(cast) ? "heart.fill" : "heart"
        heart.image = UIImage.init(systemName: heartImage)
    }
    
    @IBAction func favoriteAction() {
        // Si el cast existe...
        if let cast = cast {
            // el actor ya esta como favorito
            if DataController.shared.isFavorite(cast) {
                // y lo borras
                DataController.shared.removeFavorite(cast)
                // sino, lo añades
            } else {
                DataController.shared.addFavorite(cast)
            }
            // Que se entere el delegado, avisa la función del protocolo
            delegate?.didFavoriteChanged()
        }
    }
}
