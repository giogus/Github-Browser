//
//  SearchRepositoriesTableViewCell.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchRepositoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorLabelView: UIView!
    
    var imageURL: String!
    
    func setImage(with urlString: String){
        authorImageView.af_setImage(withURL: urlString.url,
                                    placeholderImage: nil,
                                    filter: CircleFilter(),
                                    imageTransition: .flipFromBottom(0.25))
    }
    
    func setTitleLabel(str: String){
        authorLabelView.layer.borderWidth = 1.0
        authorLabelView.layer.borderColor = UIColor.gray.cgColor
        authorLabelView.layer.cornerRadius = 5.0
        authorLabel.text = str
    }
    
}
