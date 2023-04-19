//
//  UIView+constraints.swift
//  testdevices
//
//  Created by celine dann on 28/03/2023.
//

import UIKit

extension UIView {
    func defineConstraints(height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func defineConstraints(spaceTo other: UIView, leftSpace: CGFloat? = nil, rightSpace: CGFloat? = nil, topSpace: CGFloat? = nil, bottomSpace: CGFloat? = nil, withSafeArea: Bool = false) {
        let guides = withSafeArea ? other.safeAreaLayoutGuide : other.layoutMarginsGuide
        translatesAutoresizingMaskIntoConstraints = false
        if let space = leftSpace {
            leftAnchor.constraint(equalTo: guides.leftAnchor, constant: space).isActive = true
        }
        if let space = rightSpace {
            rightAnchor.constraint(equalTo: guides.rightAnchor, constant: space).isActive = true
        }
        if let space = topSpace {
            topAnchor.constraint(equalTo: guides.topAnchor, constant: space).isActive = true
        }
        if let space = bottomSpace {
            bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: space).isActive = true
        }
    }
    
    func defineConstraints(paddingTo other: UIView, horizontal: CGFloat? = nil, vertical: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let space = horizontal {
            leftAnchor.constraint(equalTo: other.leftAnchor, constant: space).isActive = true
            rightAnchor.constraint(equalTo: other.rightAnchor, constant: -space).isActive = true
        }
        if let space = vertical {
            topAnchor.constraint(equalTo: other.topAnchor, constant: space).isActive = true
            bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: -space).isActive = true
        }
    }
    
    func defineConstraints(centerTo other: UIView, xShift: CGFloat? = nil, yShift: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        other.translatesAutoresizingMaskIntoConstraints = false
        if let shift = xShift {
            centerXAnchor.constraint(equalTo: other.centerXAnchor, constant: shift).isActive = true
        }
        if let shift = yShift {
            centerYAnchor.constraint(equalTo: other.centerYAnchor, constant: shift).isActive = true
        }
        if (xShift == nil && yShift == nil) {
            centerXAnchor.constraint(equalTo: other.centerXAnchor, constant: 0).isActive = true
            centerYAnchor.constraint(equalTo: other.centerYAnchor, constant: 0).isActive = true
        }
        
    }
    
    
}
