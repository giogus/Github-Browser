//
//  DetailRepositoryAPI.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

class DetailRepositoryAPI: DetailRepositoryStore, APIWorkerProtocol {
    
    var request: DetailRepository.FetchReadme.Request!
    
    init(request: DetailRepository.FetchReadme.Request) {
        self.request = request
    }
    
    typealias Entity = DetailRepository.FetchReadme.Response
    
    func fetchReadme(completion: @escaping (RequestResultType<Entity>) -> ()){
        let url = URLUtil.path(for: .readme(request.authorName, request.repositoryName))
        let apiWorker = APIWorker(with: url)
        apiWorker.getData(completion)
    }
}
