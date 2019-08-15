//
//  SearchView.swift
//  GoChef
//
//  Created by Edson Rottava on 07/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

//View
extension SearchController {
    
    internal func setupView() {
        //GridMoreRecipes
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: txtSearchBar.bottomAnchor, constant: Constants.spacing).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.spacing).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.spacing).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.spacing).isActive = true
    }
    
    internal func setupSearchBar() {
        //BackButton
        view.addSubview(backButton)
        //SearchBar
        view.addSubview(txtSearchBar)
    }
}
