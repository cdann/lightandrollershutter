//
//  LiveDeviceRepository.swift
//  testdevices
//
//  Created by celine dann on 31/03/2023.
//

import Foundation

class LiveDeviceRepository: DeviceRepository {
    func getDevices(handler : @escaping (Result<[Device], Error>) -> ()) {
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: "http://storage42.com/modulotest/data.json")!)
        session.dataTask(with: request) {
            (data, response, error) in
            DispatchQueue.main.async {
                if let err = error {
                    handler(.failure(err))
                    return
                }
                do {
                    guard let data = data else {
                        handler(.failure(NSError()))
                        return
                    }
                    let dto = try JSONDecoder().decode(DevicesResponse.self, from: data)
                    let devices = dto.devices.compactMap({ $0.toObject() })
                    handler(.success(devices))
                    
                } catch (let e) {
                    handler(.failure(e))
                    
                }
            }
        }.resume()
    }
}
