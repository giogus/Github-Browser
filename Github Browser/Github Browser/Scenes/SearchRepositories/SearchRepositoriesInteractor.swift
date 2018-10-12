//
//  SearchRepositoriesInteractor.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesBusinessLogic {
    
}

protocol SearchRepositoriesDataStore {
    
}

class SearchRepositoriesInteractor: SearchRepositoriesBusinessLogic, SearchRepositoriesDataStore {
    var presenter: SearchRepositoriesPresentationLogic?
    var worker: SearchRepositoriesWorker?

}
