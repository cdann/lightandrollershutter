//
//  HomeViewController.swift
//  testdevices
//
//  Created by celine dann on 28/03/2023.
//

import UIKit

class HomeViewController: UITableViewController, HomeViewModelDataDelegate {

    var modelData = HomeViewData.loading
    
    var viewModel: HomeViewModelProtocol
    
    static let loadingCellIdentifier = "loading"
    static let deviceCellIdentifier = "device"
    
    /// init
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dataDelegate = self
        viewModel.load()
        self.clearsSelectionOnViewWillAppear = false
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: HomeViewController.loadingCellIdentifier)
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: HomeViewController.deviceCellIdentifier)
        self.tableView.estimatedRowHeight = 80.0;
        tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    func display(data: HomeViewData) {
        self.modelData = data
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch modelData {
        case let .data(cells):
            return cells.count
        case .loading:
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch modelData {
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.loadingCellIdentifier, for: indexPath) as! LoadingTableViewCell
            cell.translatesAutoresizingMaskIntoConstraints = true
            cell.setup()
            return cell
        case let .data(cellsDatas):
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.deviceCellIdentifier, for: indexPath) as! DeviceTableViewCell
            cell.populate(cellsDatas[indexPath.row])
            cell.translatesAutoresizingMaskIntoConstraints = true
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch modelData {
        case .loading:
            return LoadingTableViewCell.height
        case .data(_):
            return DeviceTableViewCell.height
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch modelData {
        case .loading:
            return
        case .data(let devices):
            let device = devices[indexPath.row]
            viewModel.selectedDevice(device)
        }
    }

}
