//
//  UIView+Extensions.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import UIKit
extension UIView {
    
    func roundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
    }
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
}

