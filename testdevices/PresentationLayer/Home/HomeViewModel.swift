//
//  HomeViewModel.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var dataDelegate: HomeViewModelDataDelegate? { get set }
    /// events
    func load()
    func selectedDevice(_ device: Device)
}

protocol HomeViewModelRouter: class {
    /// meant to be implemented by the coordinatore
    /// for each navigation events called by the viewController
    func alert(text:String)
    
    func gotToDetails(_ device: Device)
}


protocol HomeViewModelDataDelegate: class {
    func display(data:HomeViewData)
}

class HomeViewModel : HomeViewModelProtocol {
    let getDevicesUC: GetDevicesUseCaseProtocol
    let router: HomeViewModelRouter?
    weak var dataDelegate: HomeViewModelDataDelegate?
    
    init(getDevicesUC: GetDevicesUseCaseProtocol, router:HomeViewModelRouter) {
        self.getDevicesUC = getDevicesUC
        self.router = router
    }
    
    func load() {
        dataDelegate?.display(data: .loading)
        getDevicesUC.execute() { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            switch result {
            case let .success(devices):
                self.dataDelegate?.display(data: .data(devices))
            case let .failure(error):
                self.router?.alert(text: error.localizedDescription)
            }
        }
    }
    
    func selectedDevice(_ device: Device) {
        print("Details for \(device)")
        router?.gotToDetails(device)
    }
    

}
