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
    
    func factorize<T>(uc: T.Type) throws -> T {
//        if (T.self == TestUseCaseProtocol.self) {
//            return TestUseCase(repository: reposFactory.getTestRepository()) as! T
//        }
        if (T.self == GetDevicesUseCaseProtocol.self) {
            return GetDeviceUseCase(repository: reposFactory.getDeviceRepository()) as! T
        }
        throw NSError()
    }
}

