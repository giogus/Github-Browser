//
//  LoadingViewController.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.text = "Loading".localized
        }
    }
    
    static let shared = UIStoryboard(name: "LoadingView", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController")
}
