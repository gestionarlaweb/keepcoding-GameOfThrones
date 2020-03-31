//
//  EpisodeDetImageCell.swift
//  AppOfThrones
//
//  Created by David Rabassa Planas on 26/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeDetImageCell : UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    
    func setEpisode(_ episode: Episode){
    thumb.image = episode.image == nil ? nil : UIImage.init(named: episode.image!)
        
    }
     
}
