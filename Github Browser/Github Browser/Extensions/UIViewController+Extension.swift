//
//  UIViewController+Extension.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        child.view.alpha = 0
        UIView.transition(with: child.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.view.addSubview(child.view)
            self.view.bringSubview(toFront: child.view)
            child.view.alpha = 1.0
        }, completion: nil)
    }
    
    func remove(_ child: UIViewController) {
        UIView.transition(with: child.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
            child.view.alpha = 0
        }, completion: { _ in
            child.view.removeFromSuperview()
        })
    }
    
}

// MARK: Loading View Logic

extension UIViewController {
    
    func showLoadingView(){
        self.navigationController?.add(LoadingViewController.shared)
    }
    
    func hideLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            self?.navigationController?.remove(LoadingViewController.shared)
        }
    }
}
