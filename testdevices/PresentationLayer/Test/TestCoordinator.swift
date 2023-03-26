//
//  TestCoordinator.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

class TestCoordinator {
    let ucFactory: UCFactory
    
    init(ucFactory: UCFactory) {
        self.ucFactory = ucFactory
    }
    
    func getViewController()  -> TestViewController? {
        if let uc = ucFactory.factorize(uc: TestUseCase.self) {
            let viewModel = TestViewModel(testUc:uc , routerDelegate: self)
            return TestViewController(viewModel: viewModel)
        }
        return nil
    }
    
}

extension TestCoordinator: TestViewModelRouterDelegate {
    
}
