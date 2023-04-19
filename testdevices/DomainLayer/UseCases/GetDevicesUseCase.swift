//
//  getDevicesUseCase.swift
//  testdevices
//
//  Created by celine dann on 28/03/2023.
//

import Foundation

protocol GetDevicesUseCaseProtocol {
    func execute(completion:  @escaping (Result<[Device], Error>) -> ())
}

class GetDeviceUseCase: GetDevicesUseCaseProtocol {
    let repository: DeviceRepository
    
    init(repository: DeviceRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Device], Error>) -> ()) {
        repository.getDevices(handler: completion)
    }
}
