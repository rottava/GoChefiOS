//
//  UserController.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class UserController: UIViewController {
    //ScrollView
    internal var scrollView: UIScrollView = UIScrollView()
    //UserImage
    internal var userImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "404"))
        image.backgroundColor = .white
        return image
    }()
    internal let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("user_name", comment: "Name");
        label.textColor = .black
        return label
    }()
    internal let userEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("user_email", comment: "Email");
        label.textColor = .black
        return label
    }()
    internal let userLogoffButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("user_logout", comment: "Logout"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(userLogout), for: .touchUpInside)
        return button
    }()
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.bgColor
        prepareSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateInfo()
    }
}
//MARK: Controller
extension UserController {
    private func prepareSetup() {
        let size: CGFloat = view.bounds.width/1.5
        userImage.frame = CGRect(x: view.bounds.midX-size/2, y: Constants.spacing+size/4, width: size, height: size)
        userImage.layer.cornerRadius = size/2
        userImage.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        userName.text = Constants.userInfo.fullName
        userEmail.text = Constants.userInfo.email
        userImage.downloaded(from: Constants.userInfo.imageURL)
        setupView()
    }
    private func updateInfo() {
        userName.text = Constants.userInfo.fullName
        userEmail.text = Constants.userInfo.email
        userImage.downloaded(from: Constants.userInfo.imageURL)
    }
    @objc
    private func userLogout() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "logoutButtonTouch"), object: nil)
    }
}
