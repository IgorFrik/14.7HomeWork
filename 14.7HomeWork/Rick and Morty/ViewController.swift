//
//  ViewController.swift
//  12.6 Домашняя работа
//
//  Created by Igor Frik on 20.07.2021.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    var categories: [Category] = []
    var idToPerson: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MainLoader().mainLoad { categories in
            self.categories = categories
            self.mainTableView.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! PersonalViewController
//        self.tableView(mainTableView, didSelectRowAt: mainTableView.indexPathForSelectedRow!)
//        PersonalLoader().personalLoader(id: idToPerson) { person in
//            vc.person = person
//            for i in person.episodes {
//                EpisodeLoader().EpisodeLoader(ep: i) { episode in
//                    vc.episodes.append(episode)
//                }
//            }
//        }
//    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        let cat = categories[indexPath.row]
        cell.id = cat.id
        cell.mainImageView.af.setImage(withURL: cat.image)
        cell.mainNameText.text = cat.name
        cell.mainStatusText.text = "\(cat.status) - \(cat.species)"
        cell.mainStatusImage.backgroundColor = cat.statusColor
        cell.mainLocationText.text = cat.lastLocation
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idToPerson = categories[indexPath.row].id
    }
}
