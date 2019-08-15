//
//  MainView.swift
//  GoChef
//
//  Created by Edson Rottava on 29/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

extension HomeController {
    
    internal func setupView() {
        prepareScrollView()
        prepareSearch()
        prepareMain()
        prepareMoreRecipe()
        prepareCollectionView()
        prepareSafetyLabel()
    }
    
    private func prepareScrollView() {
        //ScrollView
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.spacing).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //RefreshControl
        scrollView.addSubview(refreshControl)
        //HomeView
        scrollView.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.leftAnchor.constraint(equalTo: scrollView.safeLeftAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        homeView.rightAnchor.constraint(equalTo: scrollView.safeRightAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func prepareSearch() {
        //SearchBar
        homeView.addSubview(txtSearchBar)
        //BackButton
        homeView.addSubview(searchIco)
    }
    
    private func prepareMain() {
        //ImageView
        homeView.addSubview(bigImage)
        //TypeLabel
        homeView.addSubview(mainTypeLabel)
        mainTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTypeLabel.topAnchor.constraint(equalTo: bigImage.bottomAnchor, constant: Constants.spacing/2).isActive = true
        mainTypeLabel.leftAnchor.constraint(equalTo: homeView.leftAnchor, constant: Constants.spacing).isActive = true
        mainTypeLabel.rightAnchor.constraint(equalTo: homeView.rightAnchor).isActive = true
        //NameLabel
        homeView.addSubview(mainNameLabel)
        mainNameLabel.translatesAutoresizingMaskIntoConstraints = false
        mainNameLabel.topAnchor.constraint(equalTo: mainTypeLabel.bottomAnchor, constant: Constants.spacing/4).isActive = true
        mainNameLabel.leftAnchor.constraint(equalTo: homeView.leftAnchor, constant: Constants.spacing).isActive = true
        mainNameLabel.rightAnchor.constraint(equalTo: homeView.rightAnchor).isActive = true
    }
    
    private func prepareMoreRecipe() {
        //MoreRecipes
        homeView.addSubview(moreRecipesLabel)
        moreRecipesLabel.translatesAutoresizingMaskIntoConstraints = false
        moreRecipesLabel.topAnchor.constraint(equalTo: mainNameLabel.bottomAnchor, constant: Constants.spacing*1.5).isActive = true
        moreRecipesLabel.leftAnchor.constraint(equalTo: homeView.leftAnchor, constant: Constants.spacing).isActive = true
        moreRecipesLabel.rightAnchor.constraint(equalTo: homeView.rightAnchor, constant: -Constants.spacing).isActive = true
    }
    
    private func prepareCollectionView() {
        //GridMoreRecipes
        homeView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: moreRecipesLabel.bottomAnchor, constant: Constants.spacing/2).isActive = true
        collectionView.leftAnchor.constraint(equalTo: homeView.leftAnchor, constant: Constants.spacing).isActive = true
        collectionView.rightAnchor.constraint(equalTo: homeView.rightAnchor, constant: -Constants.spacing).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: Constants.cellSideSize).isActive = true
    }
    
    private func prepareSafetyLabel() {
        homeView.addSubview(safetyLabel)
        safetyLabel.translatesAutoresizingMaskIntoConstraints = false
        safetyLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        safetyLabel.leftAnchor.constraint(equalTo: homeView.leftAnchor).isActive = true
        safetyLabel.rightAnchor.constraint(equalTo: homeView.rightAnchor).isActive = true
        safetyLabel.bottomAnchor.constraint(equalTo: homeView.bottomAnchor, constant: -Constants.spacing/2).isActive = true
    }
}

