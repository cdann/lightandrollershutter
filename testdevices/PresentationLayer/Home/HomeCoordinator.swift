//
//  HomeCoordinator.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    let ucFactory: UCFactory
    let navigationController: UINavigationController
    
    init(ucFactory: UCFactory, navigationController: UINavigationController) {
        self.ucFactory = ucFactory
        self.navigationController = navigationController
    }
    
    func getViewController() throws -> UIViewController {
        let getDevicesUc = try ucFactory.factorize(uc: GetDevicesUseCaseProtocol.self)
        let viewModel = HomeViewModel(getDevicesUC: getDevicesUc, router: self)
        let vController = HomeViewController(viewModel: viewModel)
        return vController
    }
    
    deinit {
    }
    
}

extension HomeCoordinator: HomeViewModelRouter {
    func alert(text: String) {
        /// toDo: display error Alert
    }
    
    func goToDetails(_ device: Device) {
        let coordinator = DetailsCoordinator(ucFactory: ucFactory, navigationController: navigationController, device: device)
        do {
            let controller = try coordinator.getViewController()
            navigationController.pushViewController(controller, animated: true)
        } catch (let err) {
            alert(text: err.localizedDescription)
        }
    }
    
}
