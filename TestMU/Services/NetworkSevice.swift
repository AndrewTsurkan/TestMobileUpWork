//
//  NetworkSevice.swift
//  TestMU
//
//  Created by Андрей Цуркан on 23.04.2023.
//
//https://vk.com/album-128666765_266310117.
import Foundation

protocol Networking {
    func request(path: String, params: [String:String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkSevice: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        var allParams:[String:String] = [:]
        
        guard let token = authService.token else { return }
        allParams["owner_id"] = "-128666765"
        allParams["album_id"] = "266310117"
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error  in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params:[String:String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.photos
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
