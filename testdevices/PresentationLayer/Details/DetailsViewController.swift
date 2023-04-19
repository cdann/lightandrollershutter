//
//  DetailsViewController.swift
//  testdevices
//
//  Created by celine dann on 26/03/2023.
//

import UIKit

class DetailsViewController: UIViewController, UIGestureRecognizerDelegate, DetailsViewModelDataDelegate {
    
    var viewModel: DetailsViewModelProtocol
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = #colorLiteral(red: 0.6589999795, green: 0.5019999743, blue: 0.3880000114, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var header: UIView = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = #colorLiteral(red: 0.6589999795, green: 0.5019999743, blue: 0.3880000114, alpha: 1)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let header = UIView()
        header.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        header.addSubview(backButton)
        header.addSubview(titleLabel)
        backButton.defineConstraints(spaceTo: header, leftSpace: 0, topSpace: 0)
        titleLabel.defineConstraints(centerTo: header, xShift: 0)
        titleLabel.firstBaselineAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        titleLabel.defineConstraints(spaceTo: header, topSpace: 0, bottomSpace: 0)
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.leadingAnchor, constant: 20).isActive = true
        return header
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        slider.defineConstraints(width: 200)
        return slider
    }()
    
    lazy var sliderContainer: UIView = {
        let sliderContainer = UIView()
        
        sliderContainer.addSubview(slider)
        slider.defineConstraints(centerTo: sliderContainer, xShift: 0, yShift: 0)
        sliderContainer.heightAnchor.constraint(equalTo: slider.widthAnchor, constant: 40).isActive = true
        return sliderContainer
    }()
    
    lazy var switchButton: UISwitch = {
        let button = UISwitch()
        return button
    }()
    
    lazy var sliderValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.defineConstraints(height: 50)
        return label
    }()
    
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.defineConstraints(height: 50, width: 50)
        return view
    }()
    
    lazy var switchContainer: UIView = {
        let switchContainer = UIView()
        switchContainer.addSubview(switchButton)
        switchContainer.defineConstraints(centerTo: switchButton, xShift: 0, yShift: 0)
        switchButton.defineConstraints(paddingTo: switchContainer, vertical: 10)
        return switchContainer
    }()
    
    /// init
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.dataDelegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// views
    
    func setUpHeader() {
        view.addSubview(header)
        header.defineConstraints(spaceTo: view, leftSpace: 0, rightSpace: 0)
        header.defineConstraints(spaceTo: view, topSpace: 0, withSafeArea: true)
    }
    
    func setUpControls() {
        let container = UIView()
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            container.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        let vStackView = UIStackView()
        vStackView.distribution = .equalSpacing
        vStackView.axis = .vertical
        
        container.addSubview(vStackView)
        vStackView.defineConstraints(spaceTo: container, leftSpace: 0, rightSpace: 0, topSpace: 0)
        vStackView.bottomAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        let iconContainer = UIView()
        iconContainer.addSubview(iconView)
        iconContainer.defineConstraints(centerTo: iconView, xShift: 0, yShift: 0)
        iconView.defineConstraints(paddingTo: iconContainer, vertical: 10)
        vStackView.addArrangedSubview(iconContainer)
        vStackView.addArrangedSubview(switchContainer)
        vStackView.addArrangedSubview(sliderValueLabel)
        vStackView.addArrangedSubview(sliderContainer)
        switchButton.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
        slider.addTarget(self, action: #selector(movedSlider), for: .valueChanged)
    }
    

    
    func displayData(_ data: DetailsViewData) {
        titleLabel.text = data.title
        if data.doShowSlider {
            sliderContainer.isHidden = false
            sliderValueLabel.isHidden = false
            slider.value = data.sliderValuer
            sliderValueLabel.text = "\(data.percentValue)%"
        } else {
            sliderContainer.isHidden = true
            sliderValueLabel.isHidden = true
        }
        if let switchIsOn = data.isSwitchOn {
            switchContainer.isHidden = false
            switchButton.isOn = switchIsOn
        } else {
            switchContainer.isHidden = true
        }
        iconView.image = UIImage(named: data.iconName)!
    }
    
    
    
    /// lifecycle

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setUpHeader()
        setUpControls()
        viewModel.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func backAction(sender: UIButton!) {
        viewModel.backAction()
    }
    
    @objc func didSwitch(sender: UISwitch!) {
        viewModel.didSwitch(sender.isOn)
    }
    
    @objc func movedSlider(sender: UISlider!) {
        viewModel.didSlide(sender.value)
    }

    

}
