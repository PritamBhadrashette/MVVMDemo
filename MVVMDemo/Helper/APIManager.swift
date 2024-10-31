//
//  APIManager.swift
//  MVVMDemo
//
//  Created by Pritam Bhadrashette on 23/10/24.
//

import UIKit
// singleton Desing Pattern


enum DataError: Error{
    case invalidData
    case invalidResponse
    case invalidURL
    case network(Error?)
}

typealias Handler = (Result<[ProductModel], DataError>) -> Void

final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchProduct(completion: @escaping Handler ) {
        guard let url = URL(string: Constant.API.productURL) else{
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                return
            }
            
            do {
                let product = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(product))
            }catch{
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}


