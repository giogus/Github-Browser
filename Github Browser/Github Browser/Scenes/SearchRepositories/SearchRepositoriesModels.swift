//
//  SearchRepositoriesModel.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

enum SearchRepositories {
    
    // MARK: Use cases
    
    enum FetchRepositories {
        
        struct Request {
            var language: String
            var page: Int
        }
        
        struct Response: Decodable {
            var repositories: [Repository]
            
            init (repositories: [Repository]){
                self.repositories = repositories
            }
            
            private enum CodingKeys: String, CodingKey {
                case items
            }
            
            init(from decoder: Decoder) throws {
                let containersArray = try decoder.container(keyedBy: CodingKeys.self)
                let repositories = try containersArray.decode([Repository].self, forKey: .items)
                self.repositories = repositories
            }
        }
        
        struct ViewModel {
            
            struct DisplayedRepository {
                var title: String
                var description: String
                var authorImageURL: String
                var starsCount: String
                var forksCount: String
            }
            var displayedRepositories: [DisplayedRepository]
            var displayedError: BaseErrorResponse?
        }
    }
}
