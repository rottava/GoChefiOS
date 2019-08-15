//
//  FavoriteController.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Views
    internal let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    internal var favoriteView: UIView = UIView()
    internal var collectionView: UICollectionView!
    internal var filtered:[String] = Array()
    //Favorites
    internal let favoriteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = NSLocalizedString("favorite_place", comment: "Favorites");
        label.textColor = .black
        return label
    }()
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
//Func
extension FavoriteController {
    //Home
    private func prepareSetup() {
        view.backgroundColor = Constants.bgColor
        prepareGrid()
        setupView()
    }
    //GridView
    private func prepareGrid() {
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
}
//CollectionView
extension FavoriteController {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellSideSize, height: Constants.cellSideSize)
    }
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recipeItem = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! RecipeCell
        let currentId = Constants.favoritesList[indexPath.row]
        RecipeDetailService().getRecipeDetails(with: currentId) {
            (recipeDetail, error) in
            if error != nil {
                print("Error searching : \(String(describing: error))")
                return
            } else if let recipeDetail = recipeDetail {
                recipeItem.itemNameLabel.text = recipeDetail.name
                recipeItem.itemImageView.image = Helpers().getDetailImage(url: recipeDetail.images[0].imageUrlsBySize["90"]!)
                recipeItem.recipeID = currentId
            }
        }
        return recipeItem
    }
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = Constants.favoritesList.count
        return count
    }
}
