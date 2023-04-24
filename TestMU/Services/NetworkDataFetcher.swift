//
//  NetworkDataFetcher.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//

import Foundation


class NetworkDataFetcher {
    
    let networkService = NetworkSevice()
    
    
    func fetchJson(closure: @escaping (Result< [PhotosResponse], Error >) -> ()) {
        networkService.request { result in
            switch result {
            case.success(let data):
                do {
                    let response = try? JSONDecoder().decode(Response.self, from: data)
                    closure(.success(response?.response ?? []))
                }
            case.failure(let error):
                closure(.failure(error))
            }
        }
    }
}


