//
//  textFieldDelegate.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/14/21.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        if newText.length < 6 {
        return true
        }
        else {return false}
    }
}
