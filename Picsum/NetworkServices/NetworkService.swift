//
//  NetworkService.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import Foundation

protocol NetworkServiceAble {
    func fetchPhotosData(page: Int)async throws -> [TableViewItem]
}

struct NetworkService: NetworkServiceAble {
    
    
    func fetchPhotosData(page: Int) async throws -> [TableViewItem] {
        let urlString = "https://picsum.photos/v2/list?page=\(page)&limit=20"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let photos = try JSONDecoder().decode([PhotoData].self, from: data)
            return photos.map { TableViewItem(id: $0.id, author: $0.author, url: $0.url, downloadUrl: $0.downloadURL, isChecked: false)}
        } catch {
            throw NetworkError.failedToDecode
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case failedToFetch
    case failedToDecode
}
