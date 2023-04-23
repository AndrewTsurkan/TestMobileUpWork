//
//  PhotoResponse.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//

import Foundation

struct Response: Codable {
    var response: PhotosResponse
    
//    enum CodingKeys: String, CodingKey {
//        case response = "response"
//    }
}

struct PhotosResponse: Codable{
    var count: Int?
    var items: [PhotosItems]

//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case items = "items"
//    }
}

struct PhotosItems: Codable {
    var date: Int?
    var sizes: [SizePhoto]
    
//    enum CodingKeys: String, CodingKey {
//        case date = "data"
//        case sizes = "sizes"
//    }
}

struct SizePhoto: Codable {
    var type: String?
    var url: String?
    
//    enum CodingKeys: String, CodingKey {
//        case type = "type"
//        case url = "url"
//    }
}
