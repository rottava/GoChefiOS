//
//  ExpandedController.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExpandedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    //Recipe
    var recipeID: String = ""
    internal var recipeLink: String = ""
    internal var ingredients: [String] = [""]
    //ScrollView
    internal var expandedView: UIView = UIView()
    internal var scrollView: UIScrollView = UIScrollView()
    internal var collectionView: UICollectionView!
    internal let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    internal var filtered: RecipeList = RecipeList(recipeSearches: RecipeSearchResult(matches: []))
    internal var database: DatabaseReference = Database.database().reference()
    //CustomNavBar
    internal let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTouch), for: .touchUpInside)
        return button
    }()
    internal let favButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "FavOut"), for: .normal)
        button.addTarget(self, action: #selector(favButtonTouch), for: .touchUpInside)
        return button
    }()
    //BigImage
    internal let recipeImage: UIImageView = {
        let sView = UIImageView(image: UIImage(named: "404"))
        sView.backgroundColor = .white
        return sView
    }()
    internal let recipeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = NSLocalizedString("expanded_type", comment: "Type");
        label.textColor = .black
        return label
    }()
    internal let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = NSLocalizedString("expanded_name", comment: "Name");
        label.textColor = .black
        return label
    }()
    //Ingredients
    internal let recipeIngredients: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = NSLocalizedString("expanded_ingredients", comment: "Ingredients");
        label.textColor = .black
        return label
    }()
    internal let recipeIngredientsView: UITableView = {
        let sView = UITableView()
        sView.backgroundColor = .white
        return sView
    }()
    //Steps
    internal let recipeSteps: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = NSLocalizedString("expanded_steps", comment: "Steps");
        label.textColor = .black
        return label
    }()
    internal let recipeStepsView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = NSLocalizedString("item_steps", comment: "Yummly");
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    //OthersRecipes
    internal let recipeMore: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = NSLocalizedString("expanded_more", comment: "More");
        label.textColor = .black
        return label
    }()
    internal let recipeMoreView = UIScrollView()
    //Recipe website
    internal let recipeWebsite: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("expanded_url", comment: "Website"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        return button
    }()
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSetup()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFav()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
//Func
extension ExpandedController {
    //Home
    private func prepareSetup() {
        view.backgroundColor = Constants.bgColor
        //scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        recipeImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width)
        backButton.frame = CGRect(x: Constants.spacing, y: Constants.spacing, width: 20, height: 20)
        favButton.frame = CGRect(x: view.bounds.maxX-Constants.spacing-20, y: Constants.spacing, width: 20, height: 20)
        prepareGrid()
        prepareTableData()
        prepareMoreData()
        setupView()
    }
    //GridView
    private func prepareGrid() {
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width-32, height: view.bounds.height/2)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    //MoreData
    private func prepareMoreData() {
        let str = recipeNameLabel.text?.split(separator: " ").map(String.init)
        let rand = Int.random(in: 0..<(str?.count ?? 1))
        RecipeSearchService().getRecipeSearchResults(with: str?[rand] ?? Constants.recipes[rand]) {
            (searchResult, error) in
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if let searchResult = searchResult {
                self.filtered = RecipeList(recipeSearches: searchResult)
                self.collectionView?.reloadData()
            }
        }
        
    }
    //RecipeData
    private func prepareTableData() {
        recipeIngredientsView.delegate = self
        recipeIngredientsView.dataSource = self
        recipeIngredientsView.register(RecipeStep.self, forCellReuseIdentifier: Constants.stepCellIdentifier)
        recipeIngredientsView.isUserInteractionEnabled = false
        RecipeDetailService().getRecipeDetails(with: recipeID) {
            (recipeDetail, error) in
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if let recipeDetail = recipeDetail {
                self.recipeNameLabel.text = recipeDetail.name
                guard let imageUrl = recipeDetail.images[0].hostedLargeUrl else {
                    return self.recipeImage.image = Helpers().getDetailImage(url: recipeDetail.images[0].imageUrlsBySize["90"]!)
                }
                self.recipeImage.image = Helpers().getDetailImage(url: imageUrl)
                self.recipeTypeLabel.text = recipeDetail.attributes.course?[0]
                self.ingredients = recipeDetail.ingredientLines ?? ["No Ingredients Listed"]
                self.recipeLink = recipeDetail.source?.sourceRecipeUrl ?? "https://google.com"
                self.recipeIngredientsView.reloadData()
                self.recipeIngredientsView.constraints.last?.isActive = false
                self.recipeIngredientsView.bottomAnchor.constraint(equalTo: self.recipeIngredientsView.topAnchor, constant: CGFloat(self.ingredients.count) * Constants.tableSize).isActive = true
                self.view.setNeedsLayout()
            }
        }
    }
    private func setupFav() {
        if Constants.favoritesList.firstIndex(of: recipeID) != nil {
            favButton.setImage(UIImage(named: "FavIn"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "FavOut"), for: .normal)
        }
    }
    @objc
    private func openLink() {
        guard let url = URL(string: recipeLink) else { return }
        UIApplication.shared.open(url)
    }
    @objc
    private func backButtonTouch() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "backButtonTouch"), object: nil)
    }
    @objc
    private func favButtonTouch() {
        if let index = Constants.favoritesList.firstIndex(of: recipeID) {
            Constants.favoritesList.remove(at: index)
            favButton.setImage(UIImage(named: "FavOut"), for: .normal)
            database.child("users").child(Constants.userInfo.userId).child("favorites").setValue(Constants.favoritesList)
        } else {
            Constants.favoritesList.append(recipeID)
            favButton.setImage(UIImage(named: "FavIn"), for: .normal)
            database.child("users").child(Constants.userInfo.userId).child("favorites").setValue(Constants.favoritesList)
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
//CollectionView
extension ExpandedController {
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
//TableView
extension ExpandedController {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let step = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: Constants.stepCellIdentifier)
        step.textLabel?.text = ingredients[indexPath.row]
        return step
    }
}
