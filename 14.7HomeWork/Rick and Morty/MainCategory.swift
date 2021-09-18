//
//  MainCategory.swift
//  12.6 Домашняя работа
//
//  Created by Igor Frik on 25.07.2021.
//

import Foundation
import UIKit
import Alamofire

class Category{
    let id: Int
    let image: URL
    let name: String
    let status: String
    let species: String
    let statusColor: UIColor
    let lastLocation: String
    let episodes: [String]

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
    
    init?(data: NSDictionary) {
        guard let id = data["id"] as? Int,
              let image = data["image"] as? String,
              let name = data["name"] as? String,
              let status = data["status"] as? String,
              let species = data["species"] as? String,
              let lastLocation = data["location"] as? NSDictionary,
              let episodes = data["episode"] as? [String]
        else { return nil }
        self.id = id
        self.image = URL(string: image)!
        self.name = name
        self.status = status
        self.statusColor = colors.init(rawValue: status)!.color
        self.species = species
        self.lastLocation = lastLocation["name"] as! String
        self.episodes = episodes
    }
}

