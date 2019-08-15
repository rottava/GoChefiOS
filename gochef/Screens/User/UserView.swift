//
//  UserView.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

extension UserController {
    
    internal func setupView() {
        prepareScrollView()
        prepareUserImage()
        prepareUserName()
        prepareUserEmail()
        prepareUserLogoffButton()
    }
    
    private func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func prepareUserImage() {
        scrollView.addSubview(userImage)
    }
    
    private func prepareUserName() {
        scrollView.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: Constants.spacing*2).isActive = true
        userName.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: Constants.spacing).isActive = true
        userName.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -Constants.spacing).isActive = true
        userName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    private func prepareUserEmail() {
        scrollView.addSubview(userEmail)
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        userEmail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: Constants.spacing).isActive = true
        userEmail.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: Constants.spacing).isActive = true
        userEmail.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -Constants.spacing).isActive = true
        userEmail.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    private func prepareUserLogoffButton() {
        scrollView.addSubview(userLogoffButton)
        userLogoffButton.translatesAutoresizingMaskIntoConstraints = false
        userLogoffButton.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: Constants.spacing*3).isActive = true
        userLogoffButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.spacing).isActive = true
        userLogoffButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        userLogoffButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}


