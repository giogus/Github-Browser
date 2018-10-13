//
//  DetailRepositoryModels.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//


enum DetailRepository {
    
    // MARK: Use cases
    
    enum FetchReadme {
        
        struct Request {
            var repositoryName: String
            var authorName: String
        }
        
        struct Response: Decodable {
            var readme: Readme
            
            init (readme: Readme){
                self.readme = readme
            }
            
            private enum CodingKeys: String, CodingKey {
                case items
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                let readme = try container.decode(Readme.self)
                
                self.readme = readme
            }
        }
        struct ViewModel {
            
            struct DisplayedReadme {
                var urlString: String
            }
            var displayedReadme: DisplayedReadme
            var displayedError: BaseErrorResponse?
        }
    }
}
