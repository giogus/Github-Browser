//
//  SearchRepositoriesPresenter.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesPresentationLogic {
    func presentFetchedRepositories(response: SearchRepositories.FetchRepositories.Response)
    func presentFetchedRepositoriesError(error: RequestError)
    func showLoadingView()
    func hideLoadingView()
}

class SearchRepositoriesPresenter: SearchRepositoriesPresentationLogic {
    
    weak var viewController: SearchRepositoriesDisplayLogic?
 
    func presentFetchedRepositories(response: SearchRepositories.FetchRepositories.Response) {
        var displayedRepositories: [SearchRepositories.FetchRepositories.ViewModel.DisplayedRepository] = []
        for repository in response.repositories {
            let title = "\(repository.title ?? "")"
            let description = repository.description ?? ""
            let authorImageURL = repository.authorImageURL ?? ""
            let starCount = "\(repository.starsCount ?? 0)"
            let forkCount = "\(repository.forksCount ?? 0)"
            let authorName = "Created by".localized + " \(repository.authorName ?? "")"
            let displayedRepository = SearchRepositories.FetchRepositories.ViewModel.DisplayedRepository(title: title, description: description, authorImageURL: authorImageURL, starsCount: starCount, forksCount: forkCount, authorName: authorName)
            displayedRepositories.append(displayedRepository)
        }
        let viewModel = SearchRepositories.FetchRepositories.ViewModel(displayedRepositories: displayedRepositories, displayedError: nil)
        
        self.hideLoadingView()
        viewController?.displayFetchedRepositories(viewModel: viewModel)
    }
    
    func presentFetchedRepositoriesError(error: RequestError){
        
        switch error {
        case .generic(let displayedError):
            let viewModel = SearchRepositories.FetchRepositories.ViewModel(displayedRepositories: [], displayedError: displayedError)
            self.hideLoadingView()
            viewController?.displayFetchedRepositoriesError(viewModel: viewModel, isEmpty: viewModel.displayedError?.message.contains("422") ?? false)
        }
    }
    
    func showLoadingView(){
        viewController?.showLoadingView()
    }
    
    func hideLoadingView(){
        viewController?.hideLoadingView()
    }
}
