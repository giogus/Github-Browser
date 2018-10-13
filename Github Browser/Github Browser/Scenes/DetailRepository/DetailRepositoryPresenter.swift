//
//  DetailRepositoryPresenter.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol DetailRepositoryPresentationLogic {
    func presentReadmeWebview(response: DetailRepository.FetchReadme.Response)
    func presentReadmeWebviewError(error: RequestError)
    func showLoadingView()
    func hideLoadingView()
}

class DetailRepositoryPresenter: DetailRepositoryPresentationLogic {
    
    weak var viewController: DetailRepositoryDisplayLogic?
   
    func presentReadmeWebview(response: DetailRepository.FetchReadme.Response) {
        let displayedReadme = DetailRepository.FetchReadme.ViewModel.DisplayedReadme(urlString: response.readme.url ?? "")
        let viewModel = DetailRepository.FetchReadme.ViewModel(displayedReadme: displayedReadme, displayedError: nil)
        
        self.hideLoadingView()
        viewController?.displayFetchedReadme(viewModel: viewModel)
    }
    
    func presentReadmeWebviewError(error: RequestError){
        
        switch error {
        case .generic(let displayedError):
            let viewModel = DetailRepository.FetchReadme.ViewModel(displayedReadme: DetailRepository.FetchReadme.ViewModel.DisplayedReadme(urlString: ""), displayedError: displayedError)
            self.hideLoadingView()
            viewController?.displayFetchedReadmeError(viewModel: viewModel)
        }
    }
    
    func showLoadingView(){
        viewController?.showLoadingView()
    }
    
    func hideLoadingView(){
        viewController?.hideLoadingView()
    }
}
