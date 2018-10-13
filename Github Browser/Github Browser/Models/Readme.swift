//
//  Readme.swift
//  Github Browser
//
//  Created by Gustavo Severo on 13/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

struct Readme: Codable {
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case url = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decode(String.self, forKey: .url)
    }
    
    init(url: String? = ""){
        self.url = url
    }
}
