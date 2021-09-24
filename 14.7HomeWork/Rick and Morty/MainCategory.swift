//
//  MainCategory.swift
//  12.6 Домашняя работа
//
//  Created by Igor Frik on 25.07.2021.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

class Category: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var lastLocation: String = ""

    enum colors: String {
        case Alive, Dead, unknown
        
        var color: UIColor {
            switch self {
                case .Alive: return .green
                case .Dead: return .red
                case .unknown: return .gray
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    init?(data: NSDictionary) {
        guard let id = data["id"] as? Int,
              let image = data["image"] as? String,
              let name = data["name"] as? String,
              let status = data["status"] as? String,
              let species = data["species"] as? String,
              let lastLocation = data["location"] as? NSDictionary
        else { return nil }
        self.id = id
        self.image = image
        self.name = name
        self.status = status
        self.species = species
        self.lastLocation = lastLocation["name"] as! String
    }
}

