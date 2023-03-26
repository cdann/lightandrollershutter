//
//  TestViewController.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import UIKit

class TestViewController: UIViewController {
    
    let viewModel: TestViewModelProtocol
    
    /// init
    init(viewModel: TestViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// views
    
    var constraintsToActivate: [NSLayoutConstraint] = []
    var textView: UITextView!
    var container: UIView!
    
    func setUpContainer() {
        container = UIView()
        container.backgroundColor = UIColor.blue
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        constraintsToActivate.append(contentsOf: [
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            container.widthAnchor.constraint(equalToConstant: 100),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    func setUpTextView() {
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(textView)
        constraintsToActivate.append(contentsOf: [
            textView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 10),
            textView.topAnchor.constraint(equalTo: container.topAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
    }
    
    func setUpModel() {
        textView.text = viewModel.getText()
    }
    
    func setUpSubviews() {
        setUpContainer()
        setUpTextView()
        NSLayoutConstraint.activate(constraintsToActivate)
    }
    
    /// lifecycle

    override func viewDidLoad() {
        view.backgroundColor = .purple
        super.viewDidLoad()
        setUpSubviews()
        setUpModel()
    }
    

}
