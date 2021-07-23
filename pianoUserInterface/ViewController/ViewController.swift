//
//  ViewController.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 6/19/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var pianoView: PianoView! //content in the scrolling piano
   
    @IBOutlet weak var scrollView: UIScrollView! //scroll variable to us to control whether the piano can scroll or not
    @IBOutlet weak var lockButton: UIButton!
    
    
    @IBOutlet weak var sustainButton: UIButton!
    
    
    //MARK: Screen Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        //finds the height and width of the white keys
        let heightOfWhiteKeys: Float = Float(pianoView.layer.bounds.height)
        let contentViewWidth: Float = Float(pianoView.layer.bounds.width)
        let widthOfWhiteKeys: Float = contentViewWidth / Float(pianoView.totalNumberOfWhiteKeys)
        //finds the height and width of the black keys
        let heightOfBlackKeys: Float = heightOfWhiteKeys / 1.75
        let widthOfBlackKeys: Float = widthOfWhiteKeys / 1.5
        //calls the function to generate keys
        pianoView.generateKeys(heightOfWhiteKeys: heightOfWhiteKeys, widthOfWhiteKeys: widthOfWhiteKeys, heightOfBlackKeys: heightOfBlackKeys, widthOfBlackKeys: widthOfBlackKeys)
        scrollView.delaysContentTouches = false
        sustainButton.layer.cornerRadius = sustainButton.frame.width / 2
    }
    //MARK: UIButtons
    
    //controls the sustain button
    @IBAction func sustainControl(_ sender: UIButton) {
        pianoView.isSustainSelected.toggle()
        sender.isButtonSelected(isSelected: pianoView.isSustainSelected)
    }
    //controls the sustain button
    @IBAction func disableScrolling(_ sender: UIButton) {
        if(scrollView.isScrollEnabled == true){
            scrollView.isScrollEnabled = false
        }
        else{
            scrollView.isScrollEnabled = true
        }
        sender.setBackgroundImage(isSelected: scrollView.isScrollEnabled)
    }
}
