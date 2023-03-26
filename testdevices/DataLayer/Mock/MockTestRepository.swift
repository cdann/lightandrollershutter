//
//  MockRepository.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

class MockTestRepository: TestRepository {
    func getTst() -> String {
        return "Ceci est un test Mock"
    }
}
