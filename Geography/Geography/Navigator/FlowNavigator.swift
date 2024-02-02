//
//  FlowNavigator.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 18.01.24.
//

import SwiftUI
import UIKit

final class FlowNavigator: ObservableObject {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showRootView() {
        let rootView = PlaceholderViewController()
        rootView.flowNavigator = self
        window.rootViewController = UINavigationController(rootViewController: rootView)
    }
    
    func showCapitalsQuiz(countries: [NewCountry]) {
        let viewModel = CapitalsQuizViewModel()
        viewModel.countries = countries
        let capitalsQuiz = CapitalsQuiz(viewModel: viewModel)
            .environmentObject(self)
        let hostingView = UIHostingController(rootView: capitalsQuiz)
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(hostingView, animated: true)
        }
    }
    
    func showFlagsQuiz(countries: [NewCountry]) {
        let viewModel = FlagsQuizViewModel()
        viewModel.countries = countries
        let flagsQuiz = FlagsQuizView(viewModel: viewModel)
            .environmentObject(self)
        let hostingView = UIHostingController(rootView: flagsQuiz)
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(hostingView, animated: true)
        }
    }
    
    func goBack() {
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
