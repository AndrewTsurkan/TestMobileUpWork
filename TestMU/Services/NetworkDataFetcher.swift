//
//  NetworkDataFetcher.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//

import Foundation

protocol DataFetcher {
    func  getPhotos(request: @escaping (Response?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getPhotos(request: @escaping (Response?) -> Void) {
        let params = ["": ""]
        networking.request(path: API.photos, params: params) { [ weak self ] data, error in
            guard let data, let self else { return }
            if error != nil {
                print("Error")
                request(nil)
            }
                //            let response = self?.decodeJson(type: Response.self, from: data)
                let response = try? JSONDecoder().decode(Response.self, from: data)
                request(response?.response)
            }
        }
    
//    private func decodeJson<T:Codable>(type: T.Type, from: Data?) -> T? {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil}
//        return response
//
//        }
    }
    
