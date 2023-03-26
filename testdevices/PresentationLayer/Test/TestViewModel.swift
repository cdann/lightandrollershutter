//
//  TestViewModel.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

protocol TestViewModelProtocol {
    /// data resource
    func getText() -> String
    
    /// events
    /// - none
}

protocol TestViewModelRouterDelegate {
    /// meant to be implemented by the coordinatore
    /// for each navigation events called by the viewController
}

class TestViewModel : TestViewModelProtocol {
    let testUc:TestUseCaseProtocol
    let routerDelegate:TestViewModelRouterDelegate
    
    init(testUc:TestUseCaseProtocol, routerDelegate:TestViewModelRouterDelegate) {
        self.testUc = testUc
        self.routerDelegate = routerDelegate
    }
    
    func getText() -> String {
        return testUc.execute(())
    }
}
