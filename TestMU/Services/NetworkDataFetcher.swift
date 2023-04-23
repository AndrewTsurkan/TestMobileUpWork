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

class NetworkDataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    func loadData(completion: @escaping (Response?) -> ()) {
        let urlString = "https://api.vk.com/method/photos.get?album_id=266310117&v=5.131&access_token=vk1.a.QQgR2UXpvKFGWQZ06REEZ7FJ56tt20Mw4lB4PTiuYMHG6PYNkm3G69F9SJ4UDB9FnduZ_GdJ1nxXYZQoqeE6kW6CozS7lhDOFGA1d1sMZ2sHr0Q5r9_6lFdM57tR1stRXTQvAkLSeI65hWKASRpHePpJbko1NTWNt5fluDAWZ13sYg8sR0G_8Xw6bzzjzaAyZuQLE3sNJVBRgLYymGPgCw&owner_id=-128666765"
        guard let url = URL(string: urlString) else { return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data else { return }
            let response = try? JSONDecoder().decode(Response.self, from: data)
            completion(response)
        }
        task.resume()
        //"
    }
}
    
//    func getPhotos(request: @escaping (Response?) -> Void) {
//        //        let params = ["": ""]
//        //        networking.request(path: API.photos, params: params) { [ weak self ] data, error in
//        //            guard let data, let self else { return }
//        //            if error != nil {
//        //                print("Error")
//        //                request(nil)
//        //            }
//        //
//        //            let response = try? JSONDecoder().decode(Response.self, from: data)
//        //            request(response?.response)
//        //        }
//    }
        
        //    POST https://api.vk.com/method/users.get?user_ids=743784474&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131 HTTP/1.1

    
    //    private func decodeJson<T:Codable>(type: T.Type, from: Data?) -> T? {
    //        let decoder = JSONDecoder()
    //        decoder.keyDecodingStrategy = .convertFromSnakeCase
    //        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil}
    //        return response
    //
    //        }


