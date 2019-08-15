//
//  MainController.swift
//  GoChef
//
//  Created by Edson Rottava on 29/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    //ScrollView
    internal var homeView: UIView = UIView()
    internal var scrollView: UIScrollView = UIScrollView()
    internal var collectionView: UICollectionView!
    internal let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    internal var filtered: RecipeList = RecipeList(recipeSearches: RecipeSearchResult(matches: []))
    internal var first: Item!
    internal let refreshControl: UIRefreshControl = UIRefreshControl()
    //SearchBar
    internal let searchIco: UIImageView = {
        let sView = UIImageView(image: UIImage(named: "Search"))
        sView.backgroundColor = .white
        return sView
    }()
    internal var txtSearchBar: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Busca"
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    //MainRecipe
    internal let bigImage: UIImageView = {
        let sView = UIImageView(image: UIImage(named: "404"))
        sView.backgroundColor = .white
        return sView
    }()
    internal let mainTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = NSLocalizedString("main_type", comment: "Type");
        label.textColor = .black
        return label
    }()
    internal let mainNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = NSLocalizedString("main_name", comment: "Name");
        label.textColor = .black
        return label
    }()
    //OthersRecipes
    internal let moreRecipesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = NSLocalizedString("main_recipes", comment: "More");
        label.textColor = .black
        return label
    }()
    //Safety
    internal let safetyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
//MARK: Controller
extension HomeController {
    //Home
    private func prepareSetup() {
        view.backgroundColor = Constants.bgColor
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refreshRecipes), for: .valueChanged)
        //Search
        txtSearchBar.delegate = self
        txtSearchBar.frame = CGRect(x: Constants.spacing, y: Constants.spacing, width: view.bounds.width-Constants.spacing*2, height: Constants.backButtonSize*2)
        searchIco.frame = CGRect(x: Constants.spacing*2, y: Constants.spacing/2+txtSearchBar.bounds.midY, width: Constants.searchIconSize, height: Constants.searchIconSize)
        //Image
        bigImage.frame = CGRect(x: Constants.spacing, y: txtSearchBar.bounds.height + (Constants.spacing*2), width: view.bounds.width-(Constants.spacing*2), height: view.bounds.width*0.7)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recipeTouch))
        bigImage.addGestureRecognizer(tapGesture)
        bigImage.isUserInteractionEnabled = true
        prepareGrid()
        loadCollection()
        setupView()
    }
    //GridView
    private func prepareGrid() {
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: Constants.cellSideSize)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
    //PrepareRecipes
    private func loadCollection() {
        let rand = Int.random(in: 0..<Constants.recipes.count)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        txtSearchBar.addSubview(activityIndicator)
        activityIndicator.frame = txtSearchBar.bounds
        activityIndicator.startAnimating()
        RecipeSearchService().getRecipeSearchResults(with: Constants.recipes[rand]) {
            (searchResult, error) in activityIndicator.removeFromSuperview()
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if var searchResult = searchResult {
                self.first = searchResult.matches[0]
                searchResult.matches.remove(at: 0)
                self.setupFirst()
                self.filtered = RecipeList(recipeSearches: searchResult)
                self.collectionView?.reloadData()
            }
        }
        txtSearchBar.resignFirstResponder()
    }
    private func setupFirst() {
        RecipeDetailService().getRecipeDetails(with: first.id!) {
            (recipeDetail, error) in
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if let recipeDetail = recipeDetail {
                self.mainNameLabel.text = recipeDetail.name
                guard let imageUrl = recipeDetail.images[0].hostedLargeUrl else {
                    return self.bigImage.image = Helpers().getDetailImage(url: recipeDetail.images[0].imageUrlsBySize["90"]!)
                }
                self.bigImage.image = Helpers().getDetailImage(url: imageUrl)
                self.mainTypeLabel.text = recipeDetail.attributes.course?[0] ?? ""
            }
        }
    }
    //RefresRecipes
    @objc
    private func refreshRecipes() {
        loadCollection()
        view.setNeedsLayout()
        refreshControl.endRefreshing() 
    }
}
//MARK: CollectionView
extension HomeController {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellSideSize, height: Constants.cellSideSize)
    }
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recipeItem = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! RecipeCell
        let currentId = filtered.searchResults[indexPath.row].id
        RecipeDetailService().getRecipeDetails(with: currentId!) {
            (recipeDetail, error) in
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if let recipeDetail = recipeDetail {
                recipeItem.itemNameLabel.text = recipeDetail.name
                recipeItem.itemImageView.image = Helpers().getDetailImage(url: recipeDetail.images[0].imageUrlsBySize["90"]!)
                recipeItem.recipeID = currentId!
            }
        }
        return recipeItem
    }
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered.searchResults.count
    }
}
//MARK: SystemNotification
extension HomeController {
    @objc
    private func searchTouch() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadSearchView"), object: nil)
    }
    @objc
    private func recipeTouch() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadExpandedView"), object: self, userInfo: ["recipeID":first.id!])
    }
}
//MARK: SearchBar
extension HomeController {
    internal func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTouch()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
