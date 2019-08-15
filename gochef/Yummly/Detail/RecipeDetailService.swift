//
//  RecipeDetail.swift
//  GoChef
//
//  Created by Edson Rottava on 09/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

protocol DetailService {
    func getRecipeDetails(with searchPhrase: String, completionHandler: @escaping (RecipeDetail?, Error?) -> Void)
}

class RecipeDetailService: NSObject, DetailService, URLSessionDelegate {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    func getRecipeDetails(with recipeID: String, completionHandler: @escaping (RecipeDetail?, Error?) -> Void) {
        let detailUrl = "https://api.yummly.com/v1/api/recipe/\(recipeID)?_app_id=\(Constants.APP_ID)&_app_key=\(Constants.APP_KEY)"
        
        guard let request = URL(string: detailUrl) else { return }
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            guard let data = data else { return }
            
            do {
                let recipeDetail = try JSONDecoder().decode(RecipeDetail.self, from: data)
                completionHandler(recipeDetail, error)
            }  catch let jsonError {
                completionHandler(nil, error)
                print("There was an error with your API key \n", jsonError)
            }
        }
        dataTask.resume()
    }
}
