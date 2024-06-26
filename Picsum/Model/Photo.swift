//
//  Photo.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import Foundation

struct PhotoData: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String
    var isChecked = false
    
    mutating func markCheck(isChecked: Bool) {
        self.isChecked = isChecked
    }

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
