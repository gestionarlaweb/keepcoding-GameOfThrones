
import UIKit

class EpisodeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var episode: Episode?
    
    convenience init(withEpisode episode: Episode) {
        self.init(nibName: "EpisodeDetailViewController", bundle: nil)
        self.episode = episode
        self.title = episode.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI(){
        
        self.title = "Episode Detail"
        
        // Aquí REGISTRAR las dos celdas
        // CELDA 1
        let nibCellImage = UINib.init(nibName: "EpisodeDetImageCell", bundle: nil)
        self.table.register(nibCellImage, forCellReuseIdentifier: "EpisodeDetImageCell" )
        
        // CELDA 2
        let nibCellInfo = UINib.init(nibName: "EpisodeDetailInfoCell", bundle: nil)
        self.table.register(nibCellInfo, forCellReuseIdentifier: "EpisodeDetailInfoCell" )
        
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    // MARK: - UITableViewDelegate
    // Aplicar los protocolos de delegate y dataSource
    // Altura de las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    // Selección - deselección de la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - UITableViewDataSource
    // Número de secciones 2
    private func nunmerOfSections(in table: UITableView) -> Int {
        return 1
    }
    // Número de filas de la sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
       // Eres la celda 0
        if indexPath.row == 0 {
            if let cell = table.dequeueReusableCell(withIdentifier: "EpisodeDetImageCell", for: indexPath) as?
                EpisodeDetImageCell{
              
                cell.setEpisode(episode!)
            return cell
            
            }
            fatalError("Could not create Account cells")
        }
            // Eres la celda 1
             if indexPath.row == 1 {
                if let cell = table.dequeueReusableCell(withIdentifier: "EpisodeDetailInfoCell", for: indexPath) as? EpisodeDetailInfoCell{
                   
                    cell.setEpisode2(episode!)
                   return cell
                    
                }
            }
            fatalError("Could not create Account cells")
  
        
    }
    
}
