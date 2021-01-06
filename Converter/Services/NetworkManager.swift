//
//  NetworkManager.swift
//  Converter
//
//  Created by ivan on 05.01.2021.
//

import Foundation

class NetworkManager {
    
    // Достаем из JSONa нужные нам параметры
    static func fetchData(url: String, completion: @escaping (_ сurrencyModels: [CurrencyModel])->()) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let сurrencyModels = try decoder.decode([CurrencyModel].self, from: data)
                //let сurrencyModels = models
                completion(сurrencyModels)
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
