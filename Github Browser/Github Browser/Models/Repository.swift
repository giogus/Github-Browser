//
//  Repository.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

struct Repository: Codable {
    var title: String?
    var description: String?
    var authorImageURL: String?
    var authorName: String?
    var starsCount: Int?
    var forksCount: Int?
    
    private enum ItemsKeys: String, CodingKey {
        case title = "name"
        case description = "description"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
        case owner
    }
    
    private enum OwnerKeys: String, CodingKey {
        case authorImageURL = "avatar_url"
        case authorName = "login"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        title = try values.decode(String.self, forKey: .title)
        description = try? values.decode(String.self, forKey: .description)
        starsCount = try values.decode(Int.self, forKey: .starsCount)
        forksCount = try values.decode(Int.self, forKey: .forksCount)
        
        let owner = try values.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
        authorImageURL = try owner.decode(String.self, forKey: .authorImageURL)
        authorName = try owner.decode(String.self, forKey: .authorName)
    }
    
    init(title: String? = "", description: String? = "", authorImageURL: String? = "", authorName: String? = "", starsCount: Int? = 0, forksCount: Int? = 0){
        self.title = title
        self.description = description
        self.authorImageURL = authorImageURL
        self.authorName = authorName
        self.starsCount = starsCount
        self.forksCount = forksCount
    }
}
