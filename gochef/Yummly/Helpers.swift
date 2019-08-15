//
//  Helpers.swift
//  GoChef
//
//  Created by Edson Rottava on 09/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class Helpers {
    func getDetailImage(url: URL) -> UIImage {
        let newUrl = useHttps(url: url)
        
        if let imageData = try? Data(contentsOf: newUrl) {
            return UIImage(data: imageData)!
        }
        
        return UIImage()
    }
    
    func useHttps(url: URL) -> URL {
        return String(describing: url).range(of:"http:") != nil ? URL(string: String(describing: url).replacingOccurrences(of: "http:", with: "https:"))! : url
    }
    
    func createImageGradient() -> CAGradientLayer {
        let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 400)
        
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        let endColor = UIColor.black
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        return gradient
    }
}
