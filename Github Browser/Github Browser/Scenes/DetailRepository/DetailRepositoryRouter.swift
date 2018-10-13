//
//  DetailRepositoryRouter.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

@objc protocol DetailRepositoryRoutingLogic {}

protocol DetailRepositoryDataPassing {
    var dataStore: DetailRepositoryDataStore? { get }
}

class DetailRepositoryRouter: NSObject, DetailRepositoryRoutingLogic, DetailRepositoryDataPassing {
    
    weak var viewController: DetailRepositoryViewController?
    var dataStore: DetailRepositoryDataStore?
}
