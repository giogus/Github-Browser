//
//  URLUtil.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

let baseURL = "https://api.github.com"

enum Endpoints {
    case repositories (String, Int)
    case readme (String, String)
    
    var path: String {
        switch self {
        case .repositories(let language, let pageNumber):
            return "/search/repositories?q=language:\(language)&sort=stars&page=\(pageNumber)"
        case .readme(let authorName, let repositoryName):
            return "/repos/\(authorName)/\(repositoryName)/readme"
        }
    }
}

class URLUtil {
    static func path(for endpoint: Endpoints) -> String {
        return "\(baseURL)\(endpoint.path)"
    }
}
