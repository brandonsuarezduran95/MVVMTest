//
//  NetworkManager.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/9/24.
//

import Foundation

enum NetworkError: String, Error {
    case badURL
    case badServerResponse
    case badParsing
}


class NetworkManager: NSObject {
    
    func fetchData(completion: @escaping (Result<[Model], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.badServerResponse))
            }
            
            do {
                let response = try JSONDecoder().decode([Model].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.badParsing))
            }
            
        }
        .resume()
    }
}
