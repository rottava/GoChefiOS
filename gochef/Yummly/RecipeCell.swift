//
//  RecipeCell.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    //Identifier
    let cellIdentifier = "RecipeGrid"
    var recipeID = ""
    //View
    internal let itemImageView = UIImageView(image: UIImage(named: "404"))
    internal let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = NSLocalizedString("item_name", comment: "Name");
        label.textColor = .black
        return label
    }()
    //Controller
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//Extension
extension RecipeCell {
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector(("recipeTouch")))
        itemImageView.addGestureRecognizer(tapGesture)
        itemImageView.isUserInteractionEnabled = true
        //RecipeNameLabel
        addSubview(itemNameLabel)
        itemNameLabel.frame = CGRect(x: bounds.minX+4, y: bounds.maxY-14, width: bounds.width-4, height: 14)
        //RecipeImageView
        addSubview(itemImageView)
        itemImageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 18)
        itemImageView.backgroundColor = .white
    }
    @objc
    private func recipeTouch() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadExpandedView"), object: self, userInfo: ["recipeID":recipeID])
    }
}
