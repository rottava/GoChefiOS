//
//  Constants.swift
//  GoChef
//
//  Created by Edson Rottava on 07/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//
import UIKit
//import GoogleSignIn

struct Constants {
    static let APP_ID = "6ac28980"
    static let APP_KEY = "5443b0900f2ec4b050ac04c63a39aae7"
    static let backButtonSize: CGFloat = 20
    static let bgColor: UIColor = UIColor.hexColor(0xD8D8D8, alpha: 1)
    static let cellIdentifier = "RecipeGrid"
    static var cellSize = CGFloat()
    static var cellSideSize = CGFloat()
    static let dockButtonSize: CGFloat = 24
    static let dockBgColor: UIColor = UIColor.hexColor(0xACACAC, alpha: 1)
    static let dockSize: CGFloat = 65
    static var favoritesList = [String]()
    static let recipes = ["Rice", "Bean", "Meat", "Potato", "Egg", "Grain", "Milk"]
    static let searchIconSize: CGFloat = 15
    static let spacing: CGFloat = 16
    static let stepCellIdentifier = "RecipeStep"
    static let tableSize: CGFloat = 44
    static var userInfo: UserInfo = UserInfo()
}
