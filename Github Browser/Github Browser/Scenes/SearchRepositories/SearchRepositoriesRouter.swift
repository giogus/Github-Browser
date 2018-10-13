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
    
    func routeToDetailRepository(){
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "DetailRepositoryViewController") as! DetailRepositoryViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailRepository(source: dataStore!, destination: &destinationDS)
        navigateToDetailRepository(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToDetailRepository(source: SearchRepositoriesViewController, destination: DetailRepositoryViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetailRepository(source: SearchRepositoriesDataStore, destination: inout DetailRepositoryDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.repository = source.repositories![selectedRow!]
    }

}
