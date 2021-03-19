//
//  LoginController.swift
//  GoChef
//
//  Created by Edson Rottava on 29/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import GoogleSignIn
//import FBSDKCoreKit
//import FBSDKLoginKit

class LoginController: UIViewController {
    
    //BackgroundImage
    internal let bgView: UIImageView = {
        let iView = UIImageView()
        iView.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        return iView
    }()
    //LogoImage
    internal let logoView = UIImageView(image: UIImage(named: "Logo"))
    //LabelText
    internal let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("login_description", comment: "Description");
        label.textColor = .black
        label.shadowColor = .white
        return label
    }()
    //Facebook Button
    
    internal let fbButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("login_facebook", comment: "Facebook"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        //button.addTarget(self, action: #selector(logInWithFacebook), for: .touchUpInside)
        return button
    }()
    
    //Google Button
    internal let gButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("login_google", comment: "Google"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        //button.addTarget(self, action: #selector(logInWithGoogle), for: .touchUpInside)
        return button
    }()
    
    //Placeholder Button
    internal let logButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("login", comment: "Placeholder"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupGoogleLogin()
        setupView()
    }
    
    @objc
    private func login() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loginButtonTouch"), object: nil)
    }
}
/*
//GoogleLogin
extension LoginController {
    private func setupGoogleLogin() {
        GIDSignIn.sharedInstance()?.delegate = self
    }
    @objc
    private func logInWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
}
//FacebookLogin
extension LoginController {
    @objc private func logInWithFacebook() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email")) {
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            print ("Facebook: Error signing auth: %@", error)
                        } else {
                            //LOGIN SUCESS
                            print("Facebook: Login")
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "loginButtonTouch"), object: nil)
                        }
                    }
                }
            }
        })
    }
}
*/
