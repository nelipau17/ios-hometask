//
//  SceneDelegate.swift
//  ios-hometask
//
//  Created by Polina Popova on 08/10/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
          // guard = reverse if
        /*  if (windowScene = (scene as? UIWindowScene)) == nil { return }*/
            let window = UIWindow(windowScene: windowScene)
            let viewController = ViewController()
            window.rootViewController = ViewController() // Your initial view controller.
            window.makeKeyAndVisible()
            self.window = window
        }
    }

