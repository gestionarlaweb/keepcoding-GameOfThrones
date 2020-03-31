//
//  FavoritesViewController.swift
//  AppOfThrones
//
//  Created by David Rabassa Planas on 21/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit
class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var episodes: [Episode] = []
    var myEpFavorite: [Episode] = []  // Aquí me guardará todos los favoritos que existen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registro las celdas
        self.setupUI()
    }
    
    // func viewDidAppear(Bool)
    // Notifica al controlador de vista que su vista se agregó a una jerarquía de vistas.
    
    // func viewWillDisappear(Bool)
    // Notifica al controlador de vista que su vista está a punto de eliminarse de una jerarquía de vistas
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Al arrancar borrame todo los episodios que pueda haber en el array myEpFavorite
        myEpFavorite.removeAll()
    }

    // func viewDidDisappear(Bool)
    // Notifica al controlador de vista que su vista se eliminó de una jerarquía de vistas
    
    // func viewWillAppear(_ animated: Bool)
    // Notifica al controlador de vista que su vista está a punto de agregarse a una jerarquía de vistas
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Seguidamente me cargas todas las temporadas y se las paso por self a la función setupData
        // a la referencia season
        let arraySeasons = [1,2,3,4,5,6,7,8]
        for seasons in arraySeasons {
            self.setupData(season: seasons)
      }
    }
    
func setupData(season: Int) {
        if let pathURL = Bundle.main.url(forResource: "season_\(season)", withExtension: "json") {
           // print(season)
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                episodes = try decoder.decode([Episode].self, from: data)
                // Aquí se hace la comprovación de si esta o no como episode favorito
                // si lo está lo meto en el array myEpFavorite utilizando la palabra reservada append
                for episode in episodes {
                    if DataController.shared.isFavorite(episode) {
                       // print("Episodio \(episode) si que está")
                        myEpFavorite.append(episode)
                    }
                }
                tableView.reloadData()
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
        
    
}
   
    func setupUI() {
        self.title = "Favorite Episodes"
        self.navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.1)
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

        // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = myEpFavorite[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
            cell.setEpisode(episode)
            cell.rateBlock = {
                let rateViewController = RateViewController.init(withEpisode: episode)
                let navigationController = UINavigationController.init(rootViewController: rateViewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell
        }
        fatalError("Could not create Account cells")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let episode = myEpFavorite[indexPath.row]
        _ = myEpFavorite[indexPath.row]
    }
    
    // MARK: - UITableViewDatasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Una maravilla
        // me devuelve el  _ = myEpFavorite[indexPath.row] retornando las filas según las que hayan en el array
        return myEpFavorite.count
    }

}
