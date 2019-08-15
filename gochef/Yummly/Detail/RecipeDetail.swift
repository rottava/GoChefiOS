//
//  RecipeStruct.swift
//  GoChef
//
//  Created by Edson Rottava on 09/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//
import UIKit

struct RecipeDetail: Decodable {
    var id: String?
    var name: String?
    var totalTime: String?
    var images: [RecipeImage]
    var ingredientLines: [String]?
    var source: Source?
    var attributes: Attributes
}
