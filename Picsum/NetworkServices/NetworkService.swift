//
//  NetworkService.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import Foundation

protocol NetworkServiceAble {
    func fetchPhotosData(page: Int, completion: @escaping (Result<[PhotoData], Error>)-> Void)
}

struct NetworkService: NetworkServiceAble {
    
    func fetchPhotosData(page: Int, completion: @escaping (Result<[PhotoData], Error>)-> Void)  {
        let urlString = "https://picsum.photos/v2/list?page=\(page)&limit=20"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.failedToFetch))
                return
            }
            do {
                let photos = try JSONDecoder().decode([PhotoData].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(NetworkError.failedToDecode))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case failedToFetch
    case failedToDecode
}
