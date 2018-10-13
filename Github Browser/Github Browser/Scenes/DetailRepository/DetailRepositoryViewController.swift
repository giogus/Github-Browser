//
//  DetailRepositoryViewController.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol DetailRepositoryDisplayLogic: class {
    func displayFetchedReadme(viewModel: DetailRepository.FetchReadme.ViewModel)
    func displayFetchedReadmeError(viewModel: DetailRepository.FetchReadme.ViewModel)
    func showLoadingView()
    func hideLoadingView()
}

class DetailRepositoryViewController: UIViewController, DetailRepositoryDisplayLogic {
    var interactor: DetailRepositoryBusinessLogic?
    var router: (NSObjectProtocol & DetailRepositoryRoutingLogic & DetailRepositoryDataPassing)?
    
    // MARK: Data variables
    
    var displayedReadme: DetailRepository.FetchReadme.ViewModel.DisplayedReadme!
    
    // MARK: WebView
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailRepositoryInteractor()
        let presenter = DetailRepositoryPresenter()
        let router = DetailRepositoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        fetchRepositoriesOnLoad()
    }
    
    // MARK: Navigation Item Setup
    
    func setupNavigationTitle(){
        navigationItem.title = router?.dataStore?.repository?.title
    }
    
    // MARK: Fetch Methods
    
    func fetchRepositoriesOnLoad(){
        let request = DetailRepository.FetchReadme.Request(repositoryName: router?.dataStore?.repository?.title ?? "", authorName: router?.dataStore?.repository?.authorName ?? "")
        interactor?.fetchReadme(request: request)
    }
    
}

// MARK: Setup WebView

extension DetailRepositoryViewController {
    
    func displayFetchedReadme(viewModel: DetailRepository.FetchReadme.ViewModel){
        let url = viewModel.displayedReadme.urlString.url
        let requestObj = URLRequest(url: url)
        webView.loadRequest(requestObj)
    }
    
    func displayFetchedReadmeError(viewModel: DetailRepository.FetchReadme.ViewModel) {
        let alertController = UIAlertController(title: viewModel.displayedError?.title, message: viewModel.displayedError?.message, buttonText: viewModel.displayedError?.buttonText ?? "OK".localized)
        present(alertController, animated: true, completion: nil)
    }
}
