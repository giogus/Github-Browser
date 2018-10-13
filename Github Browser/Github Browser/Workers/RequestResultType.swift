//
//  RequestResultType.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

enum RequestResultType<T: Decodable> {
    case success(T)
    case failure(RequestError)
}
