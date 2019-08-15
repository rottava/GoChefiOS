//
//  RecipeList.swift
//  GoChef
//
//  Created by Edson Rottava on 09/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

struct RecipeSearchResult: Decodable {
    var matches: [Item]
}

struct Item: Decodable {
    var id: String?
    var recipeName: String?
    var imageUrlsBySize: [String: URL?]
    var sourceDisplayName: String?
}

class RecipeList {
    fileprivate var recipeSearches = RecipeSearchResult(matches: [])
    
    init(recipeSearches: RecipeSearchResult) {
        self.recipeSearches = recipeSearches
    }
    
    var searchResults: [Item] {
        get {
            return recipeSearches.matches
        }
    }
}
