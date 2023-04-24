//
//  NetworkSevice.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//

import Foundation


final class NetworkSevice {
    
    enum APIError: Error {
        case unknown
        case invalidURL
        case invalidData
    }
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getUrl(path: String) -> URL? {
        var allParams:[String:String] = [:]
        
        guard let token = authService.token else { return nil }
        allParams["owner_id"] = "-128666765"
        allParams["album_id"] = "266310117"
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        return url
    }
    
    private func url(from path: String, params:[String:String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.photos
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    func request(completion: @escaping (Result<Data,Error>) -> Void) {
        let url = getUrl(path: API.photos)
        guard let url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(APIError.unknown))
                return
            }
            guard let data else {
                completion(.failure(APIError.invalidData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}


//    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
//        return URLSession.shared.dataTask(with: request) { data, response, error  in
//            DispatchQueue.main.async {
//                completion(data, error)
//            }
//        }
//    }
