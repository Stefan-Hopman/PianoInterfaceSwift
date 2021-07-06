//
//  PianoView.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 6/25/21.
//

import UIKit

class PianoView: UIView{
    
    
    @IBOutlet weak var sustainButton: UIButton!
    
    //MARK: Look At It With Joga Singh
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    //MARK: Key Properties
    var numberOfKeys: Int = 10
    var totalNumberOfWhiteKeys:Int = 52
    var totalNumberOfBlackKeys:Int = 36
    var xPositionKey: Float = 0.0
    var yPositionKey: Float = 0.0
    var keyArray: [Key] = []
    var keysHeldDown: [Int] = []
    var orginalColorsOfKey: [CGColor] = []
    var whiteKeysArray: [WhiteKey] = [] //holds all the white keys
    var blackKeysArray: [BlackKey] = [] //holds all the black keys
    
    
    //MARK: Touch Functions
    //All the functions check if sustain is pressed 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(sustainButton.isSelected == false){
            sustainOffTouchesBegan(touches)
        }
        else{sustainOnTouchesBegan(touches)}
    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        deactivateKeys(touches)
//        stopSound()
//    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(sustainButton.isSelected == false){
        deactivateKeys(touches)
//       stopSound()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(sustainButton.isSelected == false){
        deactivateKeys(touches)
        //stopSound()
        }
    }
    
    
    //MARK: Iniliaze Layers
    var contentViewLayer: CALayer {
        self.layer //layer of content in the scroll view
    }
    var contentViewWidth : Int{
        Int(self.bounds.width) // the width of the content view
    }
    
    //MARK: Random Color Function
    func randomColor() -> CGColor{
        let ranRed = CGFloat(drand48()) //generates a random red, green, blue values from 0.0 to 1.0
        let ranGreen = CGFloat(drand48())
        let ranBlue = CGFloat(drand48())
        let ranColor = CGColor(red: ranRed, green: ranGreen, blue: ranBlue, alpha: 1.0)//generates a random color code
        return ranColor
    }
    
    //MARK: Set Properties Of The White Keys
    func whiteKeySetProperties(whiteKey: CALayer) -> CALayer {
        whiteKey.backgroundColor = UIColor.white.cgColor
        whiteKey.borderColor = UIColor.black.cgColor
        whiteKey.borderWidth = 1.5
        return whiteKey
    }
    
    //MARK: Set Properties Of The Black Keys
    func blackKeySetProperties(blackKey: CALayer) -> CALayer {
        blackKey.borderColor = UIColor.black.cgColor
        blackKey.backgroundColor = UIColor.black.cgColor
        blackKey.borderWidth = 1.0
        return blackKey
    }
    
    //MARK: Generate Keys
    func generateKeys(heightOfWhiteKeys: Float, widthOfWhiteKeys: Float, heightOfBlackKeys: Float, widthOfBlackKeys: Float){
        //counter variables
        var whiteKeyCount:Int = 0  //keeps track of the count of the white keys
        var blackKeyCount:Int = 0  //keeps track of the count of the black keys
        var twoBlackKeys = false   //checks for a pattern of two in the generation of the black keys
        
        var keyIndex: Int = 0
        for i in 0..<totalNumberOfWhiteKeys{
            let whiteKey: WhiteKey = WhiteKey()  //creates the white key
            let whiteKeyFrame = CGRect.init(x: CGFloat(widthOfWhiteKeys) * CGFloat(i), y: 0, width: CGFloat(widthOfWhiteKeys), height: CGFloat(heightOfWhiteKeys))
            whiteKey.frame = whiteKeyFrame //initialize and set the frame of the white keys
            whiteKey.keyIndex = keyIndex
            keyIndex += 1
            contentViewLayer.insertSublayer(whiteKey, at: 0)      //inserts the sublayer into the content view
            keyArray.append(whiteKey)
            whiteKeysArray.append(whiteKey)
            whiteKey.setKeyProperties(.white, .black, 1.0)
            if(blackKeyCount < totalNumberOfBlackKeys){
                //advanced algorithim to correctly place the black keys
                let initialBlackKey:Bool = (i == 1)
                let groupOfTwo = (twoBlackKeys && whiteKeyCount == 3)
                let groupOfThree = (!twoBlackKeys && whiteKeyCount == 4)
                if (initialBlackKey || groupOfTwo || groupOfThree) {
                    twoBlackKeys = !twoBlackKeys
                    whiteKeyCount = 0;
                }
                else{
                    let blackKeyFrame: CGRect = .init(x: whiteKeyFrame.origin.x + whiteKeyFrame.size.width - (CGFloat(widthOfBlackKeys)/2), y: 0, width: CGFloat(widthOfBlackKeys), height: CGFloat(heightOfBlackKeys)) //sets the dimensions and positions of the black keys
                    let blackKey: BlackKey = BlackKey()
                    blackKey.frame = blackKeyFrame
                    blackKey.keyIndex = keyIndex
                    keyIndex += 1
                    blackKey.setKeyProperties(.black, .black, 1.0)
                    blackKeyCount += 1
                    contentViewLayer.insertSublayer(blackKey, at: 1)
                    keyArray.append(blackKey)
                    blackKeysArray.append(blackKey)
                }
            }
         whiteKeyCount += 1
        }
    }
    
    //MARK: This functions finds the location of the key
    func findSelectedKeyFrom(_ touchLocation: CGPoint) -> Key? {
        for key in keyArray {
            if key.frame.contains(touchLocation) {
                return key
            }
        }
        return nil
    }
    // MARK: This functions turns on all the keys pressed
    func activateKeys(_ touches: Set<UITouch>){
        for touch in touches {
            let location = touch.location(in: self) //this function finds all your presses and the for loop is for multiple touces
            guard let key = findSelectedKeyFrom(location) else { return }
            key.isSelected = true
            //playSound()
        }
    }
    
    //MARK: This function turns off all the keys pressed
    func deactivateKeys(_ touches: Set<UITouch>){
        for touch in touches {
            let location = touch.location(in: self) //this function finds all your presses and the for loop is for multiple touces
            guard let key = findSelectedKeyFrom(location) else { return }
            key.isSelected = false
        }
    }
    
    //MARK: This function turns off all the keys pressed
    func sustainOnTouchesBegan (_ touches: Set<UITouch>){
        for touch in touches {
            let location = touch.location(in: self) //this function finds all your presses and the for loop is for multiple touces
            guard let key = findSelectedKeyFrom(location) else { return }
            if (key.isSelected == true){
            key.isSelected = false
            }
            else{
                key.isSelected = true
            }
        }
    }
    
    func sustainOffTouchesBegan(_ touches: Set<UITouch>){
        for touch in touches {
            let location = touch.location(in: self) //this function finds all your presses and the for loop is for multiple touces
            guard let key = findSelectedKeyFrom(location) else { return }
            key.isSelected = true
            //playSound()
        }
    }
    
    //switches the sustain button from on to off
    @IBAction func sustainSwitch(_ sender: Any) {
        if(sustainButton.isSelected == false){
            sustainButton.isSelected = true
        }
        else{
            sustainButton.isSelected = false
        }
        for i in 0..<keyArray.count{
            keyArray[i].isSelected = false //resets all the keys pressed
        }
    }
    
}
