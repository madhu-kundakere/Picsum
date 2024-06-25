//
//  PhotoViewModel.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import Foundation

class PhotoViewModel {
    var photos: [TableViewItem] = []
    
    private let network = NetworkService()
    private var page: Int = 1
    
    func fetchPhotosData() async  {
        do {
            let newItems = try await network.fetchPhotosData(page: page)
            self.photos.append(contentsOf: newItems)
            page += 1
        } catch {
            print(NetworkError.failedToDecode)
        }
    }
}
