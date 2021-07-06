//
//  selectedButton.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/6/21.
import UIKit

class sustainButton: UIButton {
    var isButtonSelected: Bool = true
    override func awakeFromNib(){
        super.awakeFromNib()
        isSelected = false
        addTarget(self, action: #selector(buttonTapped), for: .touchDown)
    }
    @objc func buttonTapped() {
        isButtonSelected = !isButtonSelected
    }

}

//var isButtonSelected: Bool = false {
//    didSet {
//        isButtonSelected ? selected() : unselected()
//    }
//}
