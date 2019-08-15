//
//  UIColorExt.swift
//  GoChef
//
//  Created by Edson Rottava on 29/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var tomato:UIColor{
        return self.init(red:0.67, green:0.0, blue:0.0, alpha: 1.0)
        
    }
    
    class var cheese:UIColor{
        return self.hexColor(0xfdff54, alpha: 1.0)
        
    }
    
    class var crust:UIColor{
        return self.hexColor(0xe39448, alpha: 1.0)
    }
    
    class func hexColor(_ hexColorNumber:UInt32, alpha: CGFloat) -> UIColor {
        let red = (hexColorNumber & 0xff0000) >> 16
        let green = (hexColorNumber & 0x00ff00) >> 8
        let blue = (hexColorNumber & 0x0000ff)
        return self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}
