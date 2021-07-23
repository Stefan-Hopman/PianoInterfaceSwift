//
//  Button.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/9/21.
//

import UIKit

extension UIButton{
    func isButtonSelected(isSelected: Bool){
        backgroundColor = isSelected ? .blue : .black
    }
    
    func setBackgroundImage(isSelected: Bool){
        let image = UIImage(named: isSelected ? "selectedButtonBG" : "unselectedButtonBG")
        setBackgroundImage(image, for: .normal)
    }
    func togglePause(isSelected: Bool){
        let image = UIImage(named: isSelected ? "pause" : "play")
        setImage(image, for: .normal)
    }
}
