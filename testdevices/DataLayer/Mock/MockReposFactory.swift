//
//  ReposFactory.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

enum Mock {
    class ReposFactory: ReposFactoryProtocol {
        func getDeviceRepository() -> DeviceRepository {
            return MockDeviceRepository()
        }
    }
}
