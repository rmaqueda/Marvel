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

        let layout = GroupCollectionViewLayout.layout
//        let layout = SimpleLayout.layout

        window.rootViewController = WireFrame().charactersList(layout: layout)
        window.makeKeyAndVisible()
    }
    
}
