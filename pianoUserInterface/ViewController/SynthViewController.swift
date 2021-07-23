//
//  SynthViewController.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/14/21.
//

import UIKit

class SynthViewController: UIViewController, UITextFieldDelegate{
   
    //MARK: Outlets 
    @IBOutlet weak var frequencyText: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sineButton: UIButton!
    @IBOutlet weak var squareButton: UIButton!
    @IBOutlet weak var sawButton: UIButton!
    
    //MARK: VARIABLE
    var frequency:Float?
    var tempText:String?
    var state: Bool = false
    
    
    //MARK: Text Field Delegate
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frequencyText.delegate = textFieldDelegate
        //self.sineButton.backgroundColor = .blue
    }
    
    @IBAction func togglePlay(_ sender: UIButton) {
        playButton.isSelected.toggle()
        if(!frequencyText.text!.isEmpty){
            tempText = frequencyText.text
            frequency = Float(tempText!)
            Synth.shared.frequency = frequency!
        }
        frequencyText.resignFirstResponder()
        state = !state
        state ? Synth.shared.start()  : Synth.shared.start()
        //print(playButton.isSelected)
        playButton.togglePause(isSelected: playButton.isSelected)
    }
    
    @IBAction func setSine(_ sender: UIButton) {
        sineButton.isSelected.toggle()
        sender.isButtonSelected(isSelected: sineButton.isSelected)
        deselectOtherButtons(pressedButton: sineButton)
        Synth.shared.setWaveformTo(Oscillator.sine)
    }
    @IBAction func setSquare(_ sender: UIButton) {
        squareButton.isSelected.toggle()
        sender.isButtonSelected(isSelected: squareButton.isSelected)
        deselectOtherButtons(pressedButton: squareButton)
        Synth.shared.setWaveformTo(Oscillator.square)
    }
    @IBAction func setSaw(_ sender: UIButton) {
        sawButton.isSelected.toggle()
        sender.isButtonSelected(isSelected: sawButton.isSelected)
        deselectOtherButtons(pressedButton: sawButton)
        Synth.shared.setWaveformTo(Oscillator.sawtooth)
    }
    
    func deselectOtherButtons(pressedButton: UIButton){
        if(pressedButton != sineButton){
            if(sineButton.isSelected == true){
                sineButton.isSelected.toggle()
                sineButton.isButtonSelected(isSelected: false)
            }
            //print("deselect sine called")
        }
        if(pressedButton != squareButton){
            if(squareButton.isSelected == true){
                squareButton.isSelected.toggle()
                squareButton.isButtonSelected(isSelected: false)
            }
            //print("delect square called")
        }
        if(pressedButton != sawButton){
            if(sawButton.isSelected == true){
                sawButton.isSelected.toggle()
                sawButton.isButtonSelected(isSelected: false)
            }
            //print("deselect saw called")
        }
        
    }
}
