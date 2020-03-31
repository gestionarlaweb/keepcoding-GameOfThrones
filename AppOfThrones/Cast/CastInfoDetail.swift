//
//  CastInfoDetail.swift
//  AppOfThrones
//
//  Created by David Rabassa Planas on 29/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastInfoDetail: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var episode: UILabel!
    @IBOutlet weak var dateBirth: UILabel!
    @IBOutlet weak var placeBirth: UILabel!
    
    func setCast2(_ cast: Cast){
        
        fullName.text = cast.fullname
        role.text = cast.role
        episode.text = String(cast.episodes!)
        dateBirth.text = cast.birth
        placeBirth.text = cast.placeBirth
        
    }
}
