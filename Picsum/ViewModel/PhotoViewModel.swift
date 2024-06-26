//
//  PhotoViewModel.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import Foundation

class PhotoViewModel {
    var photos: [PhotoData] = []
    private let network: NetworkServiceAble
    private var page: Int = 1

    init(networkService: NetworkServiceAble = NetworkService()) {
        self.network = networkService
    }
    
    func fetchPhotosData(onRefresh: Bool = false,completion:  @escaping () -> Void) {
        network.fetchPhotosData(page: page) { [weak self] result in
            guard let strongSelf = self else {
                completion()
                return
            }
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    if onRefresh {
                        strongSelf.photos = photos
                    } else {
                        strongSelf.photos.append(contentsOf: photos)
                        strongSelf.page += 1
                    }
                    completion()
                }
            case .failure(let error):
                completion()
                print("faild to fetch the data \(error)")
            }
        }
    }
   
    func updateCheckBoxForItem(_ index: Int, isChecked: Bool) {
            photos[index].markCheck(isChecked: isChecked)
    }
}
