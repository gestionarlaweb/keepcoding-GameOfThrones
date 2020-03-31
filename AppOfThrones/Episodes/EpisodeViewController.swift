//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EpisodeTableViewCellDelegate, FavoriteDelegate, ReviewDelegate {
   
    @IBOutlet weak var seasonSegmented: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    
    //var episodes: [Episode] = [Episode.init(id: 1, name: "Winter Is Coming", date: "April 17, 2011", image: "episodeTest", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.")]
    var episodes: [Episode] = []
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupNotifications()
        self.setupData(season: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // Elimina de esta notificación porque ya no necesito de su notificación
    // Quitamos el observador cuando se desinicialize el objeto, así no se cierra la aplicación de
    // forma inesperada
    // ¿ Cuando puede pasar eso ? Cuando le damos al boton hacia atrás por ejemplo.
    // DEINIT se encarga de eliminar ese observador porque al ir hacia atrás ya no lo necesitamos...
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
    }

    // MARK: - Setup
    
    func setupUI() {
        self.title = "Seasons"
        
        seasonSegmented.selectedSegmentTintColor = UIColor.black.withAlphaComponent(0.75)
        seasonSegmented.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        seasonSegmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.75)], for: .normal)
        
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
    }
    
    func setupData(season: Int) {
        if let pathURL = Bundle.main.url(forResource: "season_\(season)", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                episodes = try decoder.decode([Episode].self, from: data)
                table.reloadData()
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
    }
    
    // NotificationCenter (método de objetive C y te obliga a poner el puñetero @objc a la
    // funcion didFavoriteChanged() )
    // addObserver hay tres tipos y cogemos el más simple
    // rawValue: "DidFavoritesUpdated"   Nombre cualquiera
    func setupNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.didFavoriteChanged), name: noteName, object: nil)
    }
    
    // MARK: - IBActions

    // Seleccionar temporada
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        print("Temporada seleccionada \(sender.selectedSegmentIndex+1)")
        let season = sender.selectedSegmentIndex+1
        self.setupData(season: season)
        self.table.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Altura de las celdas
        return 123
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let episode = episodes[indexPath.row]
        
        let episodeDetailVC = EpisodeDetailViewController.init(withEpisode: episode)
        self.navigationController?.pushViewController(episodeDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
            cell.setEpisode(episode)
            cell.delegate = self
            cell.rateBlock = {
                let rateViewController = RateViewController.init(withEpisode: episode)
                let navigationController = UINavigationController.init(rootViewController: rateViewController)
                navigationController.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .pad ? .formSheet : .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell
        }
        fatalError("Could not create Account cells")
    }
    
    // MARK: - EpisodeTableViewCellDelegate
    
    @objc func didFavoriteChanged() {
        table.reloadData()
    }
    
    func didReviewChanged() {
        table.reloadData()
    }
}
