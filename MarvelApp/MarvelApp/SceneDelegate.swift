//
//  SceneDelegate.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 30/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let navigationController = UINavigationController()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let charactersViewController = CharacterListViewController(collectionViewLayout: layout)
        let charactersViewModel = CharacterListViewModel(viewController: charactersViewController)
        charactersViewController.onNextPage = charactersViewModel.loadNextPage
        charactersViewController.onSelect = navigateToDetails

        navigationController.setViewControllers([charactersViewController], animated: true)
        window.rootViewController = navigationController

        window.makeKeyAndVisible()

        charactersViewModel.showAllCharacters()
    }

    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()

        let width = (window?.bounds.size.width ?? 0) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        return layout
    }

    private func navigateToDetails(_ character: CharacterListViewModel.Character) {
        let viewController = CharacterDetailViewController()
        let _ = CharacterDetailViewModel(
            viewController: viewController,
            character: character)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
