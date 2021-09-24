//
//  ViewController.swift
//  12.6 Домашняя работа
//
//  Created by Igor Frik on 20.07.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
            self.mainTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainLoad()
    }
    
    func mainLoad() {
        AF.request("https://rickandmortyapi.com/api/character/?page=\(Int.random(in: 1...34))").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let jsonDict = value as? NSDictionary else { return }
                for (_, jsonObjects) in jsonDict where jsonObjects is [NSDictionary] {
                    guard let jsonSingleObj = jsonObjects as? [NSDictionary] else { return }
                    try! self.realm.write {
                        self.realm.deleteAll()
                    }
                    for jsonObject in jsonSingleObj {
                        guard let category = Category(data: jsonObject) else { return }
                        try! self.realm.write {
                            self.realm.add(category)
                        }
                    }
                    self.mainTableView.reloadData()
                }
            case .failure(let error): print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Category.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        let cat = realm.objects(Category.self)[indexPath.row]
        cell.id = cat.id
        cell.mainImageView.af.setImage(withURL: URL(string: cat.image)!)
        cell.mainNameText.text = cat.name
        cell.mainStatusText.text = "\(cat.status) - \(cat.species)"
        cell.mainStatusImage.backgroundColor = Category.colors.init(rawValue: cat.status)!.color
        cell.mainLocationText.text = cat.lastLocation
        return cell
    }
}
