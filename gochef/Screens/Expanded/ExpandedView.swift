//
//  ExpandedView.swift
//  GoChef
//
//  Created by Edson Rottava on 31/07/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

extension ExpandedController {
    
    internal func setupView() {
        prepareScrollView()
        prepareRecipeInfo()
        prepareCustomBar()
        prepareRecipeIngredients()
        prepareRecipeSteps()
        prepareMoreRecipe()
        prepareWebsiteLink()
    }
    
    private func prepareScrollView() {
        //ScrollView
        view.addSubview(scrollView)
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //HomeView
        scrollView.addSubview(expandedView)
        expandedView.translatesAutoresizingMaskIntoConstraints = false
        expandedView.leftAnchor.constraint(equalTo: scrollView.safeLeftAnchor).isActive = true
        expandedView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        expandedView.rightAnchor.constraint(equalTo: scrollView.safeRightAnchor).isActive = true
        expandedView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func prepareCustomBar() {
        //BackButton
        expandedView.addSubview(backButton)
        //FavButton
        expandedView.addSubview(favButton)
    }
    
    private func prepareRecipeInfo() {
        //Image
        expandedView.addSubview(recipeImage)
        //TypeLabel
        expandedView.addSubview(recipeTypeLabel)
        recipeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTypeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: Constants.spacing/2).isActive = true
        recipeTypeLabel.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeTypeLabel.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        //NameLabel
        expandedView.addSubview(recipeNameLabel)
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeNameLabel.topAnchor.constraint(equalTo: recipeTypeLabel.bottomAnchor, constant: Constants.spacing/3).isActive = true
        recipeNameLabel.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeNameLabel.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
    }
    
    private func prepareRecipeIngredients() {
        expandedView.addSubview(recipeIngredients)
        recipeIngredients.translatesAutoresizingMaskIntoConstraints = false
        recipeIngredients.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: Constants.spacing*1.5).isActive = true
        recipeIngredients.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeIngredients.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        expandedView.addSubview(recipeIngredientsView)
        recipeIngredientsView.translatesAutoresizingMaskIntoConstraints = false
        recipeIngredientsView.topAnchor.constraint(equalTo: recipeIngredients.bottomAnchor, constant: Constants.spacing/2).isActive = true
        recipeIngredientsView.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeIngredientsView.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        recipeIngredientsView.bottomAnchor.constraint(equalTo: recipeIngredientsView.topAnchor, constant: Constants.tableSize).isActive = true
    }
    
    private func prepareRecipeSteps() {
        expandedView.addSubview(recipeSteps)
        recipeSteps.translatesAutoresizingMaskIntoConstraints = false
        recipeSteps.topAnchor.constraint(equalTo: recipeIngredientsView.bottomAnchor, constant: Constants.spacing*1.5).isActive = true
        recipeSteps.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeSteps.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        expandedView.addSubview(recipeStepsView)
        recipeStepsView.translatesAutoresizingMaskIntoConstraints = false
        recipeStepsView.topAnchor.constraint(equalTo: recipeSteps.bottomAnchor, constant: Constants.spacing/2).isActive = true
        recipeStepsView.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeStepsView.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        recipeStepsView.bottomAnchor.constraint(equalTo: recipeStepsView.topAnchor, constant: Constants.tableSize).isActive = true
    }
    
    private func prepareMoreRecipe() {
        expandedView.addSubview(recipeMore)
        recipeMore.translatesAutoresizingMaskIntoConstraints = false
        recipeMore.topAnchor.constraint(equalTo: recipeStepsView.bottomAnchor, constant: Constants.spacing*1.5).isActive = true
        recipeMore.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeMore.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        expandedView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: recipeMore.bottomAnchor, constant: Constants.spacing/2).isActive = true
        collectionView.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        collectionView.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: collectionView.frame.height).isActive = true
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func prepareWebsiteLink() {
        expandedView.addSubview(recipeWebsite)
        recipeWebsite.translatesAutoresizingMaskIntoConstraints = false
        recipeWebsite.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        recipeWebsite.leftAnchor.constraint(equalTo: expandedView.leftAnchor, constant: Constants.spacing).isActive = true
        recipeWebsite.rightAnchor.constraint(equalTo: expandedView.rightAnchor, constant: -Constants.spacing).isActive = true
        recipeWebsite.bottomAnchor.constraint(equalTo: expandedView.bottomAnchor, constant: -Constants.spacing).isActive = true
    }
    
}
