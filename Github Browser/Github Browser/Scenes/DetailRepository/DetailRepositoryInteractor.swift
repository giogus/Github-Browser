//
//  DetailRepositoryInteractor.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

protocol DetailRepositoryBusinessLogic {
    func fetchReadme(request: DetailRepository.FetchReadme.Request)
}

protocol DetailRepositoryDataStore {
    var repository: Repository? { get set }
    var readme: Readme? { get }
}

class DetailRepositoryInteractor: DetailRepositoryBusinessLogic, DetailRepositoryDataStore {
    var presenter: DetailRepositoryPresentationLogic?
    var worker: DetailRepositoryWorker?
    
    var repository: Repository?
    var readme: Readme?
    
    func fetchReadme(request: DetailRepository.FetchReadme.Request) {
        presenter?.showLoadingView()
        
        worker = DetailRepositoryWorker(detailRepositoryStore: DetailRepositoryAPI(request: request))
        worker?.fetchReadme(completion: { readme, error  in
            
            if let unwrappedError = error {
                self.presenter?.presentReadmeWebviewError(error: unwrappedError)
                return
            }
            
            self.readme = readme
            let response = DetailRepository.FetchReadme.Response(readme: readme)
            self.presenter?.presentReadmeWebview(response: response)
        })
    }
    
}
