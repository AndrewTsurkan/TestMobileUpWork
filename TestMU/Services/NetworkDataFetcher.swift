//
//  NetworkDataFetcher.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//

import Foundation


class NetworkDataFetcher {
    
    let networkService = NetworkSevice()


    func loadData(completion: @escaping (Response?) -> ()) {
        var url = networkService.request(path: API.photos, params: ["":""])
        guard let url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data else { return }
            let response = try? JSONDecoder().decode(Response.self, from: data)
            completion(response)
        }
        task.resume()
    }
}


