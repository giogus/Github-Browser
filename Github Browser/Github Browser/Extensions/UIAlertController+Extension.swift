//
//  UIAlertController+Extension.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

extension UIAlertController {
    /// Creates a simple alert with the app default style
    ///
    /// - Parameters:
    ///   - title: Title of the UIAlertController
    ///   - message: Message of the UIAlertController
    ///   - buttonText: Action Button text of the UIAlertController
    
    convenience init (title: String?, message: String?, buttonText: String) {
        self.init(title: title, message: message, preferredStyle: .alert)
        addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
    }
}
