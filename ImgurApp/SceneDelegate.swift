//
//  SceneDelegate.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        // FeedVC Creation
        let layout = UICollectionViewFlowLayout()
        let feedViewController = FeedViewController(collectionViewLayout: layout)
        
        // Navigation Controller Setup
        let navigationController = UINavigationController(rootViewController: feedViewController)
        navigationController.navigationBar.barTintColor = .systemTeal
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let appearence = UINavigationBarAppearance()
            appearence.configureWithOpaqueBackground()
            appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearence.backgroundColor = .systemTeal
            navigationController.navigationBar.standardAppearance = appearence
            navigationController.navigationBar.scrollEdgeAppearance = appearence
        }
        
//        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController.navigationBar.isTranslucent = false

        // Making NavigationVC Root VC
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

