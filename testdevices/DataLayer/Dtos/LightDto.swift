//
//  LightDto.swift
//  testdevices
//
//  Created by celine dann on 31/03/2023.
//

import Foundation

/*
 {
             "id": 1,
             "deviceName": "Lampe - Cuisine",
             "intensity": 50,
             "mode": "ON",
             "productType": "Light"
         },
 */

struct DevicesResponse: Decodable {
    let devices: [DeviceDto]
}

struct DeviceDto: Decodable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let position: Int?
    let productType: String
}

extension DeviceDto {
    func toObject() -> Device? {
        if (productType == "Light") {
            return toLight()
        }
        if (productType == "RollerShutter") {
            return toShutter()
        }
        return nil
    }
    
    private func toLight() -> Device? {
        guard let intensity = intensity, let mode = mode else {
            return nil
        }
        return .light(Light(
            name: deviceName,
            id: id,
            isOn: mode == "ON",
            intensity: intensity))
    }
    
    private func toShutter() -> Device? {
        guard let position = position else {
            return nil
        }
        return .rollerShutter(RollerShutter(name: deviceName, id: id, position: position))
    }
}
