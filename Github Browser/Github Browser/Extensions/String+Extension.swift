//
//  String+Extension.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    var url: URL {
        return URL(string: self)!
    }
    
    var normalizedString: String {
        return self.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            .replacingOccurrences(of: "\n", with: "-")
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: ".", with: "-")
            .replacingOccurrences(of: ",", with: "-")
            .replacingOccurrences(of: "ª", with: "")
            .replacingOccurrences(of: "([-_]){2,}\\B", with: "", options: .regularExpression)
    }
}
