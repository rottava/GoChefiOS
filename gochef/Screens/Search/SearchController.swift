//
//  SearchController.swift
//  GoChef
//
//  Created by Edson Rottava on 06/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    var searchTxt: String = ""
    //CollectionViewData
    internal var filtered: RecipeList = RecipeList(recipeSearches: RecipeSearchResult(matches: []))
    internal let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    internal var collectionView: UICollectionView!
    internal var txtSearchBar: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Busca"
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    //CustomNavBar
    internal let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTouch), for: .touchUpInside)
        return button
    }()
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSetup()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
//MARK: Controller
extension SearchController {
    //Setup
    internal func prepareSetup() {
        prepareGrid()
        prepareSearchBar()
        setupSearchBar()
        setupView()
        updateSearch()
    }
    //collectionView
    internal func prepareGrid() {
        view.backgroundColor = Constants.bgColor
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
    }
    //SearchBar
    internal func prepareSearchBar() {
        let txtSearchBarSize: CGFloat = Constants.backButtonSize+Constants.spacing*2
        txtSearchBar.delegate = self
        txtSearchBar.frame = CGRect(x: txtSearchBarSize, y: Constants.spacing*2.22, width: view.bounds.width-txtSearchBarSize*2, height: Constants.backButtonSize*2)
        backButton.frame = CGRect(x: Constants.spacing, y: (Constants.spacing*2.22)+Constants.backButtonSize/2, width: Constants.backButtonSize, height: Constants.backButtonSize)
        txtSearchBar.text = searchTxt
    }
    //BackButton
    @objc
    private func backButtonTouch() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "backButtonTouch"), object: nil)
    }
}
//MARK: CollectionView
extension SearchController {
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
            }
        }
        return recipeItem
    }
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered.searchResults.count
    }
}
//MARK: SearchBar
extension SearchController {
    internal func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateSearch()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func updateSearch() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        txtSearchBar.addSubview(activityIndicator)
        activityIndicator.frame = txtSearchBar.bounds
        activityIndicator.startAnimating()
        RecipeSearchService().getRecipeSearchResults(with: txtSearchBar.text!) {
            (searchResult, error) in activityIndicator.removeFromSuperview()
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if let searchResult = searchResult {
                self.filtered = RecipeList(recipeSearches: searchResult)
                self.collectionView?.reloadData()
            }
        }
        txtSearchBar.resignFirstResponder()
    }
}
