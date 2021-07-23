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
    
    func setBackground(_ color: UIColor) {
        backgroundColor = color.cgColor
    }
    
    
    
}

class Key: CALayer {
    var isSelected: Bool = false
    var frequency = getFrequency()
    var keyIndex: Int = -1
}

class BlackKey: Key {
    
    override var isSelected: Bool {
        didSet {
            setBackground(isSelected ? .blue : .black)
        }
    }
    
    
}

class WhiteKey: Key {
    override var isSelected: Bool {
        didSet {
            setBackground(isSelected ? .blue : .white)
        }
    }
}
