//
//  MockRepository.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

class MockDeviceRepository: DeviceRepository {
    func getDevices(handler: @escaping (Result<[Device], Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            handler(.success([
                Device.light(Light(name: "Light 1", id: 2, isOn: false, intensity: 50)),
                Device.rollerShutter(RollerShutter(name: "RollerShutter 1", id: 2, position: 20))
            ]))
        }
        
    }
}
