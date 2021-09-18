//
//  MainLoader.swift
//  12.6 Домашняя работа
//
//  Created by Igor Frik on 24.07.2021.
//

import Foundation
import Alamofire

class MainLoader {
    func mainLoad(completion: @escaping ([Category]) -> Void) {
        AF.request("https://rickandmortyapi.com/api/character/?page=\(Int.random(in: 1...34))").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                var categories: [Category] = []
                guard let jsonDict = value as? NSDictionary else { return }
                for (_, jsonObjects) in jsonDict where jsonObjects is [NSDictionary] {
                    guard let jsonSingleObj = jsonObjects as? [NSDictionary] else { return }
                    for jsonObject in jsonSingleObj {
                        guard let category = Category(data: jsonObject) else { return }
                        categories.append(category)
                        }
                    }
                completion(categories)
            case .failure(let error): print(error)
            }
        }
    }
}
