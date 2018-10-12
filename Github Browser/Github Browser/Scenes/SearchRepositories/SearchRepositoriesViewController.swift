//
//  SearchRepositoriesViewController.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesDisplayLogic: class {
    
}

class SearchRepositoriesViewController: UITableViewController, SearchRepositoriesDisplayLogic {
    var interactor: SearchRepositoriesBusinessLogic?
    var router: (NSObjectProtocol & SearchRepositoriesRoutingLogic & SearchRepositoriesDataPassing)?
    
    
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
        let interactor = SearchRepositoriesInteractor()
        let presenter = SearchRepositoriesPresenter()
        let router = SearchRepositoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
