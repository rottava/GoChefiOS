//
//  RecipeItemDetail.swift
//  GoChef
//
//  Created by Edson Rottava on 09/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class RecipeItemDetail {
    fileprivate var recipeDetail: RecipeDetail
    
    init(recipeDetail: RecipeDetail) {
        self.recipeDetail = recipeDetail
    }
    
    var name: String {
        get {
            return recipeDetail.name!
        }
    }
    
    var creatorName: String {
        get {
            return recipeDetail.source!.sourceDisplayName!
        }
    }
    
    var recipeUrl: String {
        get {
            return recipeDetail.source!.sourceRecipeUrl!
        }
    }
    
    var imageUrl: URL {
        get {
            if let url = recipeDetail.images[0].hostedLargeUrl {
                return url
            }
            return recipeDetail.images[0].imageUrlsBySize["90"]!
        }
    }
    
    var ingredients: [String] {
        get {
            return recipeDetail.ingredientLines!
        }
    }
    
    var course: [String] {
        get {
            return recipeDetail.attributes.course!
        }
    }
}
