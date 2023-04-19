//
//  Light.swift
//  testdevices
//
//  Created by celine dann on 28/03/2023.
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

struct Light {
    let name: String
    let id: Int
    let isOn: Bool
    let intensity: Int
}
