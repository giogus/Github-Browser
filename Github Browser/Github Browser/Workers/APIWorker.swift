//
//  APIWorker.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation
import Alamofire

protocol APIWorkerProtocol {
    associatedtype Entity where Entity: Decodable
}

final class APIWorker {
    
    private var _url: String?
    private let _session = URLSession(configuration: .default)
    
    init(with url: String){
        self._url = url
    }
}

extension APIWorker {
    
    func getData<T: Decodable>(_ completion: @escaping (RequestResultType<T>) -> Void) {
        
        guard let unwrappedUrlString = _url,
            let url = URL(string: unwrappedUrlString) else {
                let baseErrorResponse = BaseErrorResponse(title: "Attention".localized, message: "The URL is invalid.".localized, buttonText: "OK".localized)
                completion(.failure(.generic(baseErrorResponse)))
                return
        }
        
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            
            switch response.result {
            case .success:
                
                guard let unwrappedData = response.data else {
                    let baseErrorResponse = BaseErrorResponse(title: "Attention".localized, message: "The request has returned an empty data.".localized + " ERROR: \(response.error?.localizedDescription ?? "")", buttonText: "OK".localized)
                    completion(.failure(.generic(baseErrorResponse)))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: unwrappedData)
                    completion(.success(model))
                } catch {
                    print(error)
                    let baseErrorResponse = BaseErrorResponse(title: "Decode Error".localized, message: "An error occurred when the JSON was decoded.".localized, buttonText: "OK".localized)
                    completion(.failure(.generic(baseErrorResponse)))
                }
                
            case .failure:
                let statusCode = response.response?.statusCode ?? -1
                let baseErrorResponse = BaseErrorResponse(title: "Attention".localized, message: "The request has failed with the status code".localized + " \(statusCode)", buttonText: "OK".localized)
                completion(.failure(.generic(baseErrorResponse)))
            }
        }
    }
}
