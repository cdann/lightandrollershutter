//
//  RootCoordinator.swift
//  testdevices
//
//  Created by celine dann on 28/03/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    func getViewController() throws -> UIViewController
    var ucFactory: UCFactory { get }
    var navigationController: UINavigationController { get }
}

class RootCoordinator: Coordinator {
    let ucFactory: UCFactory
    let navigationController: UINavigationController
    
    init(isMock: Bool) {
        let reposFactory: ReposFactoryProtocol = ProcessInfo.processInfo.environment["isMock"] == "1" ? Mock.ReposFactory() : Live.ReposFactory()
        ucFactory = UCFactory(reposFactory: reposFactory)
        navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func getViewController() throws -> UIViewController {
        let nextCoordinator = HomeCoordinator(ucFactory: ucFactory, navigationController: navigationController)
        let nextController = try nextCoordinator.getViewController()
        return nextController
    }
    
    func getRoot() -> UINavigationController {
        do {
            let controller = try getViewController()
            navigationController.setViewControllers([controller], animated: true)
        } catch (_) {}
        return navigationController
    }
}
