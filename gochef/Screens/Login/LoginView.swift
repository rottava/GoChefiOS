//
//  LoginView.swift
//  GoChef
//
//  Created by Edson Rottava on 29/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

extension LoginController {
    
    internal func setupView() {
        prepareBackground()
        prepareLogo()
        prepareDescription()
        prepareLogin()
        //prepareFacebook()
        //prepareGoogle()
    }
    
    private func prepareBackground() {
        view.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func prepareLogo() {
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        logoView.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: Constants.spacing*4).isActive = true
        logoView.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -Constants.spacing*4).isActive = true
        logoView.contentMode = .scaleAspectFit
    }
    
    private func prepareDescription() {
        view.addSubview(descLabel)
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: Constants.spacing*2).isActive = true
        descLabel.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -Constants.spacing*2).isActive = true
        descLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.spacing*4).isActive = true
    }
    
    private func prepareFacebook() {
        view.addSubview(fbButton)
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fbButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: Constants.spacing*2).isActive = true
        fbButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func prepareGoogle() {
        view.addSubview(gButton)
        gButton.translatesAutoresizingMaskIntoConstraints = false
        gButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gButton.topAnchor.constraint(equalTo: fbButton.bottomAnchor, constant: Constants.spacing).isActive = true
        gButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func prepareLogin() {
        view.addSubview(logButton)
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: Constants.spacing*2).isActive = true
        logButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
