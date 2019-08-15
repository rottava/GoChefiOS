//
//  SplashView.swift
//  GoChef
//
//  Created by Edson Rottava on 30/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//
import UIKit
//SplashView
extension SystemController {
    internal func prepareSplash() {
        //Background
        let background: UIImageView = {
            let iView = UIImageView()
            iView.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
            return iView
        }()
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //Logo
        let logo = UIImageView(image: UIImage(named: "Logo"))
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        logo.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: Constants.spacing*4).isActive = true
        logo.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -Constants.spacing*4).isActive = true
        logo.contentMode = .scaleAspectFit
    }
}

