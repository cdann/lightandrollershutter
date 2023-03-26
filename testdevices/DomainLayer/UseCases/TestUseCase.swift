//
//  TestUseCase.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

protocol TestUseCaseProtocol {
    func execute(_ arg: Void) -> String
}

class TestUseCase: TestUseCaseProtocol {
    let repository: TestRepository
    
    init(repository: TestRepository) {
        self.repository = repository
    }
    
    func execute(_ arg: Void) -> String {
        return repository.getTst()
    }
}
