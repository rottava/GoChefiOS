//
//  FavoriteView.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

extension FavoriteController {
    
    internal func setupView() {
        prepareFavoriteView()
        prepareFavoriteLabel()
        prepareGridView()
    }
    
    private func prepareFavoriteView() {
        view.addSubview(favoriteView)
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        favoriteView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoriteView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        favoriteView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        favoriteView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func prepareFavoriteLabel() {
        favoriteView.addSubview(favoriteLabel)
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteLabel.topAnchor.constraint(equalTo: favoriteView.topAnchor, constant: Constants.spacing*2).isActive = true
        favoriteLabel.centerXAnchor.constraint(equalTo: favoriteView.centerXAnchor).isActive = true
    }
    
    private func prepareGridView() {
        favoriteView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: Constants.spacing/2).isActive = true
        collectionView.leftAnchor.constraint(equalTo: favoriteView.leftAnchor, constant: Constants.spacing).isActive = true
        collectionView.rightAnchor.constraint(equalTo: favoriteView.rightAnchor, constant: -Constants.spacing).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: favoriteView.bottomAnchor, constant: 0).isActive = true
    }
    
}
