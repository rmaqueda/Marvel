//
//  WireFrame.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 6/5/22.
//

import Foundation
import UIKit

struct WireFrame {
    let navigationController = UINavigationController()

    func charactersList(layout: UICollectionViewLayout) -> UIViewController {
        let charactersViewController = CharacterListViewController(collectionViewLayout: layout)
        let charactersViewModel = CharacterListViewModel(viewController: charactersViewController)
        charactersViewController.onNextPage = charactersViewModel.nextPage
        charactersViewController.onSelect = characterDetail
        charactersViewModel.showAllCharacters()

        navigationController.setViewControllers([charactersViewController], animated: true)
        
        return navigationController
    }

    func characterDetail(character: MarvelCharacter) {
        let viewController = CharacterDetailViewController()
        _ = CharacterDetailViewModel(
            viewController: viewController,
            character: character)

        navigationController.pushViewController(viewController, animated: true)
    }

}
