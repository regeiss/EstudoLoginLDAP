//
//  NetworkService.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 23/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

//
//  NetworkingService.swift
//  Database Login
//
//  Created by Kyle Lee on 2/17/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

enum MyResult<T, E: Error> {
    
    case success(T)
    case failure(E)
}

class NetworkingService {
    
    let baseUrl = "https://kiloloco.herokuapp.com/api"
    
//    func handleResponse(for request: URLRequest,
//                        completion: @escaping (Result<Usuario, Error>) -> Void) {
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            DispatchQueue.main.async {
//
//                guard let unwrappedResponse = response as? HTTPURLResponse else {
//                    completion(.failure(NetworkingError.badResponse))
//                    return
//                }
//
//                print(unwrappedResponse.statusCode)
//
//                switch unwrappedResponse.statusCode {
//
//                case 200 ..< 300:
//                    print("success")
//
//                default:
//                    print("failure")
//                }
//
//                if let unwrappedError = error {
//                    completion(.failure(unwrappedError))
//                    return
//                }
//
//                if let unwrappedData = data {
//
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
//                        print(json)
//
//                        if let user = try? JSONDecoder().decode(Usuario.self, from: unwrappedData) {
//                            completion(.success(user))
//
//                        } else {
//                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
//                            completion(.failure(errorResponse))
//                        }
//
//                    } catch {
//                        completion(.failure(error))
//                    }
//                }
//            }
//        }
//
//        task.resume()
//    }
//
//    func request(endpoint: String,
//                 parameters: [String: Any],
//                 completion: @escaping (Result<Usuario, Error>) -> Void) {
//
//        guard let url = URL(string: baseUrl + endpoint) else {
//            completion(.failure(NetworkingError.badUrl))
//            return
//        }
//
//        var request = URLRequest(url: url)
//
//        var components = URLComponents()
//
//        var queryItems = [URLQueryItem]()
//
//        for (key, value) in parameters {
//
//            let queryItem = URLQueryItem(name: key, value: String(describing: value))
//            queryItems.append(queryItem)
//        }
//
//        components.queryItems = queryItems
//
//        // username=kiloloco&password=pass123
//        let queryItemData = components.query?.data(using: .utf8)
//
//        request.httpBody = queryItemData
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        handleResponse(for: request, completion: completion)
//    }
//
//    func request(endpoint: String,
//                 loginObject: Login,
//                 completion: @escaping (Result<Usuario, Error>) -> Void) {
//
//        guard let url = URL(string: baseUrl + endpoint) else {
//            completion(.failure(NetworkingError.badUrl))
//            return
//        }
//
//        var request = URLRequest(url: url)
//
//        do {
//            let loginData = try JSONEncoder().encode(loginObject)
//            request.httpBody = loginData
//
//        } catch {
//            completion(.failure(NetworkingError.badEncoding))
//        }
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        handleResponse(for: request, completion: completion)
//    }
    
    
}

enum NetworkingError: Error {
    case badUrl
    case badResponse
    case badEncoding
}
