//
//  SystemController.swift
//  GoChef
//
//  Created by Edson Rottava on 29/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import GoogleSignIn
//import FBSDKLoginKit
//import FirebaseDatabase

class SystemController: UIViewController, UIGestureRecognizerDelegate {
    
    internal var currentScreen: screen = .splash
    internal let homeController: UIViewController = HomeController()
    internal let favoriteController: UIViewController = FavoriteController()
    internal let userController: UIViewController = UserController()
    internal var screenFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    internal let dockView: UIView = UIView()
    //internal var database: DatabaseReference = Database.database().reference()
    
    internal let homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Home"), for: .normal)
        button.addTarget(self, action: #selector(loadHomeView), for: .touchUpInside)
        return button
    }()
    internal var homeText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = NSLocalizedString("dock_home", comment: "Home");
        label.textColor = .black
        return label
    }()
    internal let favButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "FavIn"), for: .normal)
        button.addTarget(self, action: #selector(loadFavoriteView), for: .touchUpInside)
        return button
    }()
    internal let favText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = NSLocalizedString("dock_favorite", comment: "Favoritos");
        label.textColor = .black
        return label
    }()
    internal let userButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "User"), for: .normal)
        button.addTarget(self, action: #selector(loadUserView), for: .touchUpInside)
        return button
    }()
    internal let userText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = NSLocalizedString("dock_user", comment: "Perfil");
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (currentScreen == screen.splash) {
            iniConstants()
            iniNavigationController()
            prepareSplash()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if (currentScreen == screen.splash) {
            loginTry()
        }
    }
}
//MARK: SystemController
extension SystemController {
    //SwipeBack
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            return false
        }
        return true
    }
    //InitConstants
    internal func iniConstants() {
        Constants.cellSize = view.bounds.width * 0.85
        Constants.cellSideSize = Constants.cellSize / 2
    }
    //InitNavigationController
    internal func iniNavigationController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(loginButtonTouch(_:)), name: Notification.Name(rawValue: "loginButtonTouch"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logoutButtonTouch(_:)), name: Notification.Name(rawValue: "logoutButtonTouch"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(backButtonTouch(_:)), name: Notification.Name(rawValue: "backButtonTouch"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadExpandedView(_:)), name: Notification.Name(rawValue: "loadExpandedView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadSearchView(_:)), name: Notification.Name(rawValue: "loadSearchView"), object: nil)
    }
    //Load Expanded View
    internal func loadExpandedView(id: String) {
        var viewController: UIViewController = UINavigationController.init()
        viewController = ExpandedController()
        let vc = viewController as! ExpandedController
        vc.recipeID = id
        navigationController?.pushViewController(vc, animated: true)
    }
    //Load Login View
    internal func loadLoginView() {
        currentScreen = screen.login
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        var viewController: UIViewController = UINavigationController.init()
        viewController = LoginController()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(viewController, animated: false)
    }
    //Load User View
    internal func loadSearchView(searchTxt: String) {
        var viewController: UIViewController = UINavigationController.init()
        viewController = SearchController()
        let vc = viewController as! SearchController
        vc.searchTxt = searchTxt
        navigationController?.pushViewController(vc, animated: true)
    }
    //Try to login
    internal func loginTry() {
        self.prepareSetup()
        /*
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                // User is signed in.
                self.prepareSetup()
            } else {
                // No user is signed in.
                self.loadLoginView()
            }
        }
        */
    }
    //DockNav
    internal func prepareDock() {
        dockView.backgroundColor = Constants.dockBgColor
        dockView.frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY-Constants.dockSize, width: view.bounds.width, height: Constants.dockSize)
        let midY = Constants.dockSize/2 - Constants.dockButtonSize/2 - 7
        homeButton.frame = CGRect(x: dockView.bounds.midX/2-Constants.dockButtonSize/2, y: midY, width: Constants.dockButtonSize, height: Constants.dockButtonSize)
        favButton.frame = CGRect(x: dockView.bounds.midX-Constants.dockButtonSize/2, y: midY, width: Constants.dockButtonSize, height: Constants.dockButtonSize)
        userButton.frame = CGRect(x: dockView.bounds.midX*1.5-Constants.dockButtonSize/2, y: midY, width: Constants.dockButtonSize, height: Constants.dockButtonSize)
        view.addSubview(dockView)
        dockView.addSubview(homeButton)
        dockView.addSubview(homeText)
        homeText.translatesAutoresizingMaskIntoConstraints = false
        homeText.topAnchor.constraint(equalTo: homeButton.bottomAnchor).isActive = true
        homeText.centerXAnchor.constraint(equalTo: homeButton.centerXAnchor).isActive = true
        dockView.addSubview(favButton)
        dockView.addSubview(favText)
        favText.translatesAutoresizingMaskIntoConstraints = false
        favText.topAnchor.constraint(equalTo: favButton.bottomAnchor).isActive = true
        favText.centerXAnchor.constraint(equalTo: favButton.centerXAnchor).isActive = true
        dockView.addSubview(userButton)
        dockView.addSubview(userText)
        userText.translatesAutoresizingMaskIntoConstraints = false
        userText.topAnchor.constraint(equalTo: userButton.bottomAnchor).isActive = true
        userText.centerXAnchor.constraint(equalTo: userButton.centerXAnchor).isActive = true
    }
    //Setup
    internal func prepareSetup() {
        screenFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-Constants.dockSize)
        prepareUser()
        prepareDock()
        loadHomeView()
    }
    //User
    internal func prepareUser() {
        Constants.userInfo.userId = "123456"
        Constants.userInfo.idToken = "0"
        Constants.userInfo.fullName = NSLocalizedString("user_name", comment: "Name")
        Constants.userInfo.email = NSLocalizedString("user_email", comment: "Email")
        Constants.userInfo.imageURL = URL(string: "")
        Constants.favoritesList = [String]()
        /*
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            Constants.userInfo.userId = user.uid
            Constants.userInfo.idToken = user.refreshToken ?? "0"
            Constants.userInfo.fullName = user.displayName ?? NSLocalizedString("user_name", comment: "Name")
            Constants.userInfo.email = user.email ?? NSLocalizedString("user_email", comment: "Email")
            Constants.userInfo.imageURL = user.photoURL
            Constants.favoritesList = [String]()
            database.child("users").child(Constants.userInfo.userId).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                if let itens = snapshot.value as? NSArray {
                    for i in 0..<itens.count {
                        Constants.favoritesList.append(itens[i] as! String)
                    }
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
         */
    }
    //List of views
    internal enum screen {
        case splash
        case login
        case home
        case favorite
        case user
        case expanded
        case search
    }
}

//MARK: SystemNotifications
extension SystemController {
    //Back Button Press
    @objc
    internal func backButtonTouch(_ notification: Notification) {
        navigationController?.popViewController(animated: true)
    }
    //Load Expanded View
    @objc
    internal func loadExpandedView(_ notification: Notification) {
        if let id = notification.userInfo?["recipeID"] as? String {
            loadExpandedView(id: id)
        }
    }
    //Load Search View
    @objc
    internal func loadSearchView(_ notification: Notification) {
        if let searchTxt = notification.userInfo?["searchTxt"] as? String {
            loadSearchView(searchTxt: searchTxt)
        }
    }
    //Login Button Press
    @objc
    internal func loginButtonTouch(_ notification: Notification) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
        prepareSetup()
    }
    //Logout Button Press
    @objc
    internal func logoutButtonTouch(_ notification: Notification) {
        /*
        if((FBSDKAccessToken.current()) != nil) {
            fbLogout()
        } else {
            GIDSignIn.sharedInstance()?.signOut()
            GIDSignIn.sharedInstance().disconnect()
        }
         */
    }
    /*
    private func fbLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logOut()
            print("Facebook: Logout")
        } catch let signOutError as NSError {
            print ("Facebook: Error signing out: %@", signOutError)
        }
    }
    */
}
//MARK: DockNavigation
extension SystemController {
    @objc
    internal func loadFavoriteView() {
        removeActiveView()
        currentScreen = screen.favorite
        addActiveView()
    }
    @objc
    internal func loadHomeView() {
        removeActiveView()
        currentScreen = screen.home
        addActiveView()
    }
    @objc
    internal func loadUserView() {
        removeActiveView()
        currentScreen = screen.user
        addActiveView()
    }
    @objc
    internal func removeActiveView() {
        switch (currentScreen) {
        case screen.home:
            removeView(asChildViewController: homeController)
            homeText.textColor = .black
            homeButton.setImage(UIImage(named: "Home"), for: .normal)
            break
        case screen.favorite:
            removeView(asChildViewController: favoriteController)
            favText.textColor = .black
            favButton.setImage(UIImage(named: "FavIn"), for: .normal)
            break
        case screen.user:
            removeView(asChildViewController: userController)
            userText.textColor = .black
            userButton.setImage(UIImage(named: "User"), for: .normal)
            break
        default:
            break
        }
    }
    @objc
    internal func addActiveView() {
        switch (currentScreen) {
        case screen.home:
            addView(asChildViewController: homeController)
            homeText.textColor = .white
            homeButton.setImage(UIImage(named: "HomeInv"), for: .normal)
            break
        case screen.favorite:
            addView(asChildViewController: favoriteController)
            favText.textColor = .white
            favButton.setImage(UIImage(named: "FavInv"), for: .normal)
            break
        case screen.user:
            addView(asChildViewController: userController)
            userText.textColor = .white
            userText.textColor = .white
            userButton.setImage(UIImage(named: "UserInv"), for: .normal)
            break
        default:
            break
        }
    }
    internal func addView(asChildViewController viewController: UIViewController) {
        view.addSubview(viewController.view)
        viewController.view.frame = screenFrame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    internal func removeView(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
