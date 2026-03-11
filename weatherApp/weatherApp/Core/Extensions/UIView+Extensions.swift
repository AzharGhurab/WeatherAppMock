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
        self.layer.masksToBounds = true
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }
}

