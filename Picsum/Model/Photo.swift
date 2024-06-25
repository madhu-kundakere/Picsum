//
//  Photo.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import Foundation

// MARK: - PhotoData
struct PhotoData: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
