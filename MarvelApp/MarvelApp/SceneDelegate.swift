//
//  SceneDelegate.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 30/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = CharacterListViewController()
        self.window = window
        window.makeKeyAndVisible()
    }

}
