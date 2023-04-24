//
//  PhotoResponse.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//

import Foundation

struct Response: Codable {
    var response: PhotosResponse
}

struct PhotosResponse: Codable{
    var count: Int?
    var items: [PhotosItems]
}

struct PhotosItems: Codable {
    var date: Int?
    var sizes: [SizePhoto]
}

struct SizePhoto: Codable {
    var type: String?
    var url: String?
}
