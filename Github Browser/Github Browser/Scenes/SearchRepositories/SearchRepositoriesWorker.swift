//
//  SearchRepositoriesWorker.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesStore {
    func fetchRepositories(completion: @escaping (RequestResultType<SearchRepositories.FetchRepositories.Response>) -> ())
}

class SearchRepositoriesWorker {
    
    var searchRepositoriesStore: SearchRepositoriesStore
    
    init (searchRepositoriesStore: SearchRepositoriesStore){
        self.searchRepositoriesStore = searchRepositoriesStore
    }
    
    func fetchRepositories(completion: @escaping ([Repository], RequestError?) -> ()){
        searchRepositoriesStore.fetchRepositories(completion: {  result in
            switch result {
            case .success(let response):
                completion(response.repositories, nil)
                break
            case .failure(let requestError):
                completion([], requestError)
                break
            }
        })
    }
}
