//
//  CastViewDetailController.swift
//  AppOfThrones
//
//  Created by David Rabassa Planas on 29/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastViewDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Meto en una variable el objeto
    var casts: Cast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        //self.setupData()
    }
    
    // Paso el objeto cast
    convenience init(withCast cast: Cast) {
        self.init(nibName: "CastViewDetailController", bundle: nil)
        self.casts = cast
        self.title = cast.fullname
    }
   
    func setupUI(){
        self.title = "Cast Detail"
        
        // Registrar las dos celdas
        // CELDA 1
        let nibCellImage = UINib.init(nibName: "CastImageDetail", bundle: nil)
        self.tableView.register(nibCellImage, forCellReuseIdentifier: "CastImageDetail" )
        
        // CELDA 2
        let nibCellInfo = UINib.init(nibName: "CastInfoDetail", bundle: nil)
        self.tableView.register(nibCellInfo, forCellReuseIdentifier: "CastInfoDetail" )
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    // MARK: - UITableViewDelegate
    // Aplicar los protocolos de delegate y dataSource
    // Altura de las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    // Selección - deselección de la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: - UITableViewDataSource
    // Número de secciones 1
    private func nunmerOfSections(in table: UITableView) -> Int {
        return 1
    }
    // Número de filas de la sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    // Número de filas de la sección
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Eres la celda 0
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CastImageDetail", for: indexPath) as? CastImageDetail{
                cell.setCast(casts!)
            return cell
            }
            fatalError("Could not create Account cells")
        }
            // Eres la celda 1
             if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "CastInfoDetail", for: indexPath) as? CastInfoDetail{
                    cell.setCast2(casts!)
                    return cell
                }
            }
            fatalError("Could not create Account cells")
    }
    
}
