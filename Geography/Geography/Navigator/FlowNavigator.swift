//
//  FlowNavigator.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 18.01.24.
//

import SwiftUI
import UIKit

final class FlowCoordinator: ObservableObject {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showRootView() {
//        let swiftUIView = ContentView()
//            .environmentObject(self)
//        let hostingView = UIHostingController(rootView: swiftUIView)
//        window.rootViewController = UINavigationController(rootViewController: hostingView)
    }
    
    func showDetailView() {
//        let detailView = DetailView()
//            .environmentObject(self)
//        let viewController = UIHostingController(rootView: detailView)
//        window.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func closeDetailView() {
        // Needs to be more sophisticated later when there are more views
        window.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
