//
//  SearchRepositoriesWorker.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesStore {}

class SearchRepositoriesWorker {
    
    var searchRepositoriesStore: SearchRepositoriesStore
    
    init (searchRepositoriesStore: SearchRepositoriesStore){
        self.searchRepositoriesStore = searchRepositoriesStore
    }
}
