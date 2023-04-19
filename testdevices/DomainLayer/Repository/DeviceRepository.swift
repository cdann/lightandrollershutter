//
//  DeviceRepository.swift
//  testdevices
//
//  Created by celine dann on 31/03/2023.
//

import Foundation

protocol DeviceRepository {
    func getDevices(handler : @escaping (Result<[Device], Error>) -> ())
}
