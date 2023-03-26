//
//  UC.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation


class UCFactory {
    let reposFactory: ReposFactoryProtocol
    
    init(reposFactory: ReposFactoryProtocol) {
        self.reposFactory = reposFactory
    }
    
    func factorize<T>(uc: T.Type) -> T? {
        if (T.self == TestUseCase.self) {
            return TestUseCase(repository: reposFactory.getTestRepository()) as! T
        }
        return nil
    }
}

