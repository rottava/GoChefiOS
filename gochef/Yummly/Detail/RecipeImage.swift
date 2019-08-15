//
//  RecipeImage.swift
//  GoChef
//
//  Created by Edson Rottava on 09/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

struct RecipeImage: Decodable {
    var hostedLargeUrl: URL?
    var imageUrlsBySize: [String: URL]
}
