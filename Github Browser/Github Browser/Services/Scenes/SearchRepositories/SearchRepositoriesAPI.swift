//
//  SearchRepositoriesAPI.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

class SearchRepositoriesAPI: SearchRepositoriesStore, APIWorkerProtocol {
    
    var request: SearchRepositories.FetchRepositories.Request!
    
    init(request: SearchRepositories.FetchRepositories.Request) {
        self.request = request
    }
    
    typealias Entity = SearchRepositories.FetchRepositories.Response
    
    func fetchRepositories(completion: @escaping (RequestResultType<Entity>) -> ()){
        let languageNormalized = request.language.normalizedString
        let url = URLUtil.path(for: .repositories(languageNormalized, request.page))
        let apiWorker = APIWorker(with: url)
        apiWorker.getData(completion)
    }
}
