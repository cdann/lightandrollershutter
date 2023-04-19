//
//  DetailsViewData.swift
//  testdevices
//
//  Created by celine dann on 03/04/2023.
//

import Foundation

struct DetailsViewData {
    
    enum DeviceType {
        case light
        case shutter
    }
    
    let title: String
    let doShowSlider: Bool
    let sliderValuer: Float
    let percentValue: Int
    let isSwitchOn: Bool?
    let deviceType: DeviceType // for wording
    let iconName:String
}
