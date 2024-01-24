//
//  SceneDelegate.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var flowController = FlowNavigator(window: window!)
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        flowController.showRootView()
        window?.makeKeyAndVisible()
    }
}


