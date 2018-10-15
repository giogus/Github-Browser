//
//  DetailRepositoryWorker.swift
//
//
//  Created by Gustavo Severo on 13/10/18.
//

import UIKit

protocol DetailRepositoryStore {
    func fetchReadme(completion: @escaping (RequestResultType<DetailRepository.FetchReadme.Response>) -> ())
}

class DetailRepositoryWorker {
    
    var detailRepositoryStore: DetailRepositoryStore
    
    init (detailRepositoryStore: DetailRepositoryStore){
        self.detailRepositoryStore = detailRepositoryStore
    }
    
    func fetchReadme(completion: @escaping (Readme, RequestError?) -> ()){
        detailRepositoryStore.fetchReadme(completion: {  result in
            switch result {
            case .success(let response):
                completion(response.readme, nil)
                break
            case .failure(let requestError):
                completion(Readme(), requestError)
                break
            }
        })
    }
    
}

