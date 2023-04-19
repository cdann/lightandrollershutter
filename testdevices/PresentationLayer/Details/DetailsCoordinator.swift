//
//  DetailsCoordinator.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {
    let ucFactory: UCFactory
    let navigationController: UINavigationController
    let device: Device
    
    
    init(ucFactory: UCFactory, navigationController: UINavigationController, device: Device) {
        self.ucFactory = ucFactory
        self.navigationController = navigationController
        self.device = device
    }
    
    func getViewController() throws -> UIViewController {
        let viewModel = DetailsViewModel(router: self, device: device)
        let controller = DetailsViewController(viewModel: viewModel)
        let vController = controller
        return vController
    }
    
}

extension DetailsCoordinator: DetailsViewModelRouter {
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
