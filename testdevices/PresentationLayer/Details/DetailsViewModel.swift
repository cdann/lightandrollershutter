//
//  TestViewModel.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    var dataDelegate: DetailsViewModelDataDelegate? { get set }
    func load()
    func didSwitch(_ value: Bool)
    func didSlide(_ value: Float)
    /// events
    func backAction()
}

protocol DetailsViewModelRouter {
    /// meant to be implemented by the coordinatore
    /// for each navigation events called by the viewController
    func goBack()
}

protocol DetailsViewModelDataDelegate: class {
    func displayData(_ data: DetailsViewData)
}

class DetailsViewModel : DetailsViewModelProtocol {
    let router:DetailsViewModelRouter
    weak var dataDelegate: DetailsViewModelDataDelegate?
    let device: Device
    var lastData: DetailsViewData?
    
    init(router:DetailsViewModelRouter, device:Device) {
        self.router = router
        self.device = device
    }
    
    func load() {
        let data: DetailsViewData
        switch (device) {
        case .light(let l):
            data = DetailsViewData(
                title: l.name,
                doShowSlider: l.isOn,
                sliderValuer: Float(l.intensity) / 100,
                percentValue: l.intensity,
                isSwitchOn: l.isOn,
                deviceType: .light,
                iconName: l.isOn ? "DeviceLightOnIcon" : "DeviceLightOffIcon")
            break;
        case .rollerShutter(let r):
            data = DetailsViewData(
                title: r.name,
                doShowSlider: true,
                sliderValuer: Float(r.position) / 100,
                percentValue: r.position,
                isSwitchOn: nil,
                deviceType: .shutter,
                iconName: "DeviceRollerShutterIcon")
        }
        display(data)
    }
    
    private func display(_ data: DetailsViewData) {
        lastData = data
        dataDelegate?.displayData(data)
    }
    
    func backAction() {
        router.goBack()
    }
    
    func didSwitch(_ value: Bool) {
        print("switched \(value)")
        guard let lastData = lastData else {
            return
        }
        let data: DetailsViewData
        
        switch (device) {
        case .light(_):
            data = DetailsViewData(
                title: lastData.title,
                doShowSlider: value,
                sliderValuer: lastData.sliderValuer,
                percentValue: lastData.percentValue,
                isSwitchOn: value,
                deviceType: .light,
                iconName: value ? "DeviceLightOnIcon" : "DeviceLightOffIcon")
            break;
        default:
            data = lastData
        }
        
        display(data)
    }
    
    func didSlide(_ value: Float) {
        print("slided \(value)")
        guard let lastData = lastData else {
            return
        }
        let data = DetailsViewData(
            title: lastData.title,
            doShowSlider: lastData.doShowSlider,
            sliderValuer: value,
            percentValue: Int(round(value * 100)),
            isSwitchOn: lastData.isSwitchOn,
            deviceType: lastData.deviceType,
            iconName: lastData.iconName)
        display(data)
    }
    
}
