//
//  PianoView.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 6/25/21.
//

import UIKit

class PianoView: UIView{
    
    //MARK: Touch Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchBegan")
        
        for touch in touches {
            let location = touch.location(in: self) //this function finds all your presses and the for loop is for multiple touces
            findSelectedKey(touchLocation: location)
            //print("touchBegan: ", location)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesEnded")
    }
    
    //MARK: Key Properties
    var numberOfKeys: Int = 10
    var totalNumberOfWhiteKeys:Int = 52 //52
    var totalNumberOfBlackKeys:Int = 36
    var xPositionKey: Float = 0.0
    var yPositionKey: Float = 0.0
    var keyArray: [CALayer] = []
    func printKeyArray(){
        print(keyArray.count)
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
    //MARK: Set Properties Of White Keys
    func whiteKeySetProperties(whiteKey: CALayer) -> CALayer {
        whiteKey.backgroundColor = UIColor.white.cgColor
        whiteKey.borderColor = UIColor.black.cgColor
        whiteKey.borderWidth = 1.5
        return whiteKey
    }
    
    //MARK: Set Properties Of Black Keys
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
        
        for i in 0..<totalNumberOfWhiteKeys{
            let whiteKey: CALayer = CALayer()  //creates the white key
            let whiteKeyFrame = CGRect.init(x: CGFloat(widthOfWhiteKeys) * CGFloat(i), y: 0, width: CGFloat(widthOfWhiteKeys), height: CGFloat(heightOfWhiteKeys))
            whiteKey.frame = whiteKeyFrame                        //initialize and set the frame of the white keys
            contentViewLayer.insertSublayer(whiteKey, at: 0)      //inserts the sublayer into the content view
            keyArray.append(whiteKey)
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
                    let blackKey: CALayer = CALayer()
                    blackKey.frame = blackKeyFrame
                    blackKey.setKeyProperties(.black, .black, 1.0)
                    blackKeyCount += 1
                    contentViewLayer.insertSublayer(blackKey, at: 1)
                    keyArray.append(blackKey)
                }
            }
         whiteKeyCount += 1
        }
    }
    
    func findSelectedKey(touchLocation: CGPoint){
        for j in 0..<keyArray.count {
            //goes through each key and see's if they mathc in position and height
            if(touchLocation.x >= keyArray[j].frame.origin.x && touchLocation.x <= (keyArray[j].frame.origin.x + keyArray[j].frame.size.width) && touchLocation.y <= keyArray[j].frame.size.height){
                //checks to see if it was a black key or white key pressed
                if(j == 87){ //checks to see if it the ultimate key 
                    print("Key Number \(j+1)")
                }
                else{
                    if(touchLocation.x >= keyArray[j+1].frame.origin.x && touchLocation.x <= (keyArray[j+1].frame.origin.x + keyArray[j+1].frame.size.width) && touchLocation.y <= keyArray[j+1].frame.size.height){
                        if(keyArray[j].frame.size.height < keyArray[j+1].frame.size.height){
                            print("Key Number \(j+1)")
                            break
                        }
                        else{
                            print("Key Number \(j+2)")
                            break
                        }
                    }
                        else{
                            print("Key Number \(j+1)")
                            break
                        }
                }
            }
        }
    }
}
