//
//  SearchRepositoriesRouter.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

@objc protocol SearchRepositoriesRoutingLogic {
    func routeToDetailRepository()
}

protocol SearchRepositoriesDataPassing {
    var dataStore: SearchRepositoriesDataStore? { get }
}

class SearchRepositoriesRouter: NSObject, SearchRepositoriesRoutingLogic, SearchRepositoriesDataPassing {

    weak var viewController: SearchRepositoriesViewController?
    var dataStore: SearchRepositoriesDataStore?
    
    // MARK: Routing
    
    func routeToDetailRepository() {
        
    }
    
    // MARK: Navigation
    
//    func navigateToDetailRepository(source: SearchRepositoriesViewController, destination: DetailRepositoryViewController) {
//        source.show(destination, sender: nil)
//    }

}
