//
//  EpisodeDetailInfoCell.swift
//  AppOfThrones
//
//  Created by David Rabassa Planas on 26/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeDetailInfoCell : UITableViewCell {
    // Nombre episodio -name-
    @IBOutlet weak var name: UILabel!
    // Data -date- int
    @IBOutlet weak var date: UILabel!
    // Capitulo -season- int
    @IBOutlet weak var season: UILabel!
    // Episodio -epi- int
    @IBOutlet weak var epi: UILabel!
    // Descripción -overview-
    @IBOutlet weak var overview: UITextView!
    
    func setEpisode2(_ episode: Episode){
    
        name.text  = episode.name
        date.text = episode.date
        epi.text = String(episode.episode)
        season.text = String(episode.season)
        overview.text = episode.overview
        
    }
}
