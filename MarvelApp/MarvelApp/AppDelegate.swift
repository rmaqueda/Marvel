//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 30/4/22.
//

import UIKit
import MarvelAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var session: URLSession = {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let diskCacheURL = cachesURL.appendingPathComponent("DownloadCache")
        let cache = URLCache(memoryCapacity: 10_000_000, diskCapacity: 1_000_000_000, directory: diskCacheURL)

        let config = URLSessionConfiguration.default
        config.urlCache = cache

        return URLSession(configuration: config)
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }

}
