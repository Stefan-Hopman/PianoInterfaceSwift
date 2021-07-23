//
//  FrequencyGenerator.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/23/21.
//

import Foundation


var octave:Float = 0
var count:Int = 9
var echo:Float = 440.0
var baseFrequency = echo * pow(2, -4.75)

    func getFrequency() -> Float {
        let p = pow(2, Float(count)/12.0)
        let f = baseFrequency * p
        count += 1
        return f
    }

