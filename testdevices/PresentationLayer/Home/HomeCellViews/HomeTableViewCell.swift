//
//  LoadingTableViewCell.swift
//  testdevices
//
//  Created by celine dann on 28/03/2023.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    static let height: CGFloat = 200

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
    }
    
    func setup(){
        let loader = UIActivityIndicatorView()
        let container = UIView()
        
        contentView.addSubview(container)
        
        container.defineConstraints(spaceTo: contentView, leftSpace: 0, rightSpace: 0, topSpace: 0, bottomSpace: 0)
        container.addSubview(loader)
        loader.startAnimating()
        loader.defineConstraints(centerTo: container, xShift: 0, yShift: 0)
        loader.defineConstraints(spaceTo: container, topSpace: 20)
    }

}


class DeviceTableViewCell: UITableViewCell {
    static let height: CGFloat = 70
    
    func populate(_ device: Device) {
        let linesStackView = UIStackView(arrangedSubviews: lines(for: device))
        linesStackView.axis = .vertical
        linesStackView.distribution = .fillProportionally
        let arrowView = UIImageView(image: UIImage(systemName: "arrow.right"))
        arrowView.contentMode = .scaleAspectFit
        arrowView.tintColor = .orange
        arrowView.defineConstraints(width: 20)
        let image:UIImage
        switch device {
        case .light(_):
            image = UIImage(named: "DeviceLightOnIcon")!
        case .rollerShutter(_):
            image = UIImage(named: "DeviceRollerShutterIcon")!
        }
        let iconView = UIImageView(image: image)
        
        iconView.defineConstraints(height: 20, width: 20)
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .orange
        let imageContainer = UIView()
        imageContainer.addSubview(iconView)
        imageContainer.trailingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10).isActive = true
        imageContainer.heightAnchor.constraint(greaterThanOrEqualTo: iconView.heightAnchor, multiplier: 1).isActive = true
        imageContainer.widthAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: 1, constant: 10).isActive = true
        let hStackView = UIStackView(arrangedSubviews: [imageContainer, linesStackView, arrowView])
        hStackView.distribution = .fillProportionally
        contentView.addSubview(hStackView)
        hStackView.defineConstraints(paddingTo: contentView, horizontal: 10, vertical: 10)
    }
    
    private func  lines(for device:Device) -> [UILabel] {
        var lines:[UILabel] = []
        switch device {
        case let .light(light):
            let titleLabel = UILabel()
            titleLabel.text = "\(NSLocalizedString("light_cell_title", comment: "")) \(light.name)"
            titleLabel.textColor = .orange
            lines.append(titleLabel)
            
            let line2 = UILabel()
            line2.text = light.isOn ? NSLocalizedString("on", comment: "") : NSLocalizedString("off", comment: "")
            lines.append(line2)
            
            if (light.isOn){
                let line3 = UILabel()
                line3.text = "\(light.intensity)% \(NSLocalizedString("intensity", comment: ""))"
                lines.append(line3)
            }
        case .rollerShutter(let roller):
            let titleLabel = UILabel()
            titleLabel.text = "\(NSLocalizedString("roller_cell_title", comment: "")) \(roller.name)"
            titleLabel.textColor = .orange
            lines.append(titleLabel)
            
            let line2 = UILabel()
            switch roller.position {
            case 0:
                line2.text = NSLocalizedString("fully_closed", comment: "")
            case 100:
                line2.text = NSLocalizedString("fully_opened", comment: "")
            default:
                line2.text = "\(roller.position)% \(NSLocalizedString("opened_ratio", comment: ""))"
            }
            lines.append(line2)
        }
        return lines
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
