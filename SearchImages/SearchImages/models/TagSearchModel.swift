//
//  TagSearchModel.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation

struct TagSearchModel: Codable {
    let response: [TagSearchResponse]
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

struct TagSearchResponse: Codable {
    let photos: [TagSearchPhotos]?
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

struct TagSearchPhotos: Codable {
    let originalSize: TagSearchPhotosOrigSize
    
    enum CodingKeys: String, CodingKey {
        case originalSize = "original_size"
    }
}

struct TagSearchPhotosOrigSize: Codable {
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
