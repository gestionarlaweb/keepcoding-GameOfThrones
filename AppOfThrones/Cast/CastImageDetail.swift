//
//  CastImageDetail.swift
//  AppOfThrones
//
//  Created by David Rabassa Planas on 29/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastImageDetail: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    
    func setCast(_ cast: Cast){
        thumb.image = cast.avatar == nil ? nil : UIImage.init(named: cast.avatar!)
    }
}

