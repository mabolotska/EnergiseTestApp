//
//  NetworkManager.swift
//  EnergiseTestApp
//
//  Created by Maryna Bolotska on 01/05/24.
//

import UIKit
import Alamofire


class NetworkManager {
    static let shared = NetworkManager()

    private init() { }

    typealias completionHandler = (Result<Map, Error>) -> Void

    func fetchData<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void) {

        AF.request(url, method: .get, parameters: nil, headers: nil).validate().responseDecodable(of: T.self) {  response in

            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
