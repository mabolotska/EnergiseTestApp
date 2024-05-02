//
//  NetworkManager.swift
//  EnergiseTestApp


import UIKit
import Alamofire


class NetworkManager {
    static let shared = NetworkManager()

    private init() { }

    let sessionManager: Session = {

      let configuration = URLSessionConfiguration.af.default

      configuration.timeoutIntervalForRequest = 30
      configuration.waitsForConnectivity = true

        configuration.requestCachePolicy = .returnCacheDataElseLoad

        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })
      return Session(
        configuration: configuration,
        cachedResponseHandler: responseCacher)
    }()

    typealias completionHandler = (Result<Map, Error>) -> Void

    func fetchData(url: String, completionHandler: @escaping completionHandler) {
        AF.request(url, method: .get, parameters: nil, headers: nil).validate().responseDecodable(of: Map.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }



}
