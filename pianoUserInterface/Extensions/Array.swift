//
//  Array.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/23/21.
//

import Foundation


extension Array{
    func objectAt<T>(_ index: Int) -> T? {
            if count > 0 && (index >= 0 || index < count) {
                return self[index] as? T
            }
            return nil
        }
}
