//
//  Layer.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 6/25/21.
//

import UIKit


extension CALayer {
    
    func setKeyProperties(_ color: UIColor, _ colorBorder: UIColor, _ borderWidthSize: CGFloat) {
        backgroundColor = color.cgColor
        borderColor = colorBorder.cgColor
        borderWidth = borderWidthSize
        cornerRadius = 7
        maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

//extension UIView {
//   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
