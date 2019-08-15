//
//  RecipeStep.swift
//  GoChef
//
//  Created by Edson Rottava on 12/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class RecipeStep: UITableViewCell {
    //Identifier
    let stepCellIdentifier = "RecipeStep"
    internal let itemStepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = NSLocalizedString("item_name", comment: "Name");
        label.textColor = .black
        return label
    }()
}
extension RecipeStep {
    private func setupView() {
        //RecipeNameLabel
        addSubview(itemStepLabel)
        itemStepLabel.frame = CGRect(x: bounds.minX+4, y: bounds.maxY-14, width: bounds.width-4, height: 14)
    }
}
