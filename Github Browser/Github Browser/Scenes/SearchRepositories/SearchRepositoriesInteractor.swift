//
//  SearchRepositoriesInteractor.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesBusinessLogic {
    func fetchRepositories(request: SearchRepositories.FetchRepositories.Request, shouldRefresh: Bool)
}

protocol SearchRepositoriesDataStore {
    var repositories: [Repository]? { get }
}

class SearchRepositoriesInteractor: SearchRepositoriesBusinessLogic, SearchRepositoriesDataStore {
    var presenter: SearchRepositoriesPresentationLogic?
    var worker: SearchRepositoriesWorker?

    var repositories: [Repository]?
    
    func fetchRepositories(request: SearchRepositories.FetchRepositories.Request, shouldRefresh: Bool) {
        
        presenter?.showLoadingView()
        
        worker = SearchRepositoriesWorker(searchRepositoriesStore: SearchRepositoriesAPI(request: request))
        worker?.fetchRepositories(completion: { repositories, error  in
            
            if let unwrappedError = error {
                self.presenter?.presentFetchedRepositoriesError(error: unwrappedError)
                return
            }
            
            if let repos = self.repositories {
                if repos.count > 0 && !shouldRefresh {
                    self.repositories?.append(contentsOf: repositories)
                    let response = SearchRepositories.FetchRepositories.Response(repositories: self.repositories!)
                    self.presenter?.presentFetchedRepositories(response: response)
                    return
                }
            }
            
            self.repositories = repositories
            let response = SearchRepositories.FetchRepositories.Response(repositories: repositories)
            self.presenter?.presentFetchedRepositories(response: response)
        })
    }
}
