//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    private var episode: Episode?
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    
    convenience init(withEpisode episode: Episode) {
        self.init(nibName: "RateViewController", bundle: nil)
        self.episode = episode
        self.title = episode.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func confirm(_ sender: Any) {
        let rate = Double(Int(rateSlider.value * 5)/10)
        if let episode = episode {
            DataController.shared.rateEpisode(episode, value: rate)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateChanged(_ sender: UISlider) {
        let rate = Double(Int(sender.value * 5)/10)
        rateLabel.text = String(rate)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
