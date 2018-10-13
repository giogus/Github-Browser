//
//  RequestError.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

struct BaseErrorResponse {
    var title: String
    var message: String
    var buttonText: String
    
    init(title: String = "Error".localized, message: String = "A generic error occurred. Try again later.".localized, buttonText: String = "OK".localized) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
    }
}

enum RequestError: Error {
    case generic(BaseErrorResponse)
}
