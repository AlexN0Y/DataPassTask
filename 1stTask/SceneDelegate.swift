//
//  SceneDelegate.swift
//  1stTask
//
//  Created by Alex Gav on 28.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let resultStoryboard = UIStoryboard(name: "ResultStoryboard", bundle: nil)
        let initialVC = resultStoryboard.instantiateInitialViewController()
        
        let navigationController = UINavigationController(rootViewController: initialVC!)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }
    
}

