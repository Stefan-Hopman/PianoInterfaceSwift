//
//  ViewController.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 6/19/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var contentView: UIView! //content in the scrolling piano
    
    //MARK: Key Properties
    var numberOfKeys: Int = 10
    var totalNumberOfWhiteKeys:Int = 52 //52
    var totalNumberOfBlackKeys:Int = 36
    var xPositionKey: Float = 0.0
    var yPositionKey: Float = 0.0
    
  
    //MARK: Iniliaze Layers
    var contentViewLayer: CALayer {
        contentView.layer //layer of content in the scroll view
    }
    var contentViewWidth : Int{
        Int(contentView.bounds.width) // the width of the content view
    }
    
    //MARK: Screen Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        //finds the height and width of the white keys
        let heightOfWhiteKeys: Float = Float(contentView.layer.bounds.height)
        let contentViewWidth: Float = Float(contentView.layer.bounds.width)
        let widthOfWhiteKeys: Float = contentViewWidth / Float(totalNumberOfWhiteKeys)
        //finds the height and width of the black keys
        let heightOfBlackKeys: Float = heightOfWhiteKeys / 1.75
        let widthOfBlackKeys: Float = widthOfWhiteKeys / 1.5
        //calls the function to generate keys
        generateKeys(heightOfWhiteKeys: heightOfWhiteKeys, widthOfWhiteKeys: widthOfWhiteKeys, heightOfBlackKeys: heightOfBlackKeys, widthOfBlackKeys: widthOfBlackKeys)
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
            var whiteKey: CALayer = CALayer()  //creates the white key
            let whiteKeyFrame = CGRect.init(x: CGFloat(widthOfWhiteKeys) * CGFloat(i), y: 0, width: CGFloat(widthOfWhiteKeys), height: CGFloat(heightOfWhiteKeys))
            whiteKey.frame = whiteKeyFrame                        //initialize and set the frame of the white keys
            whiteKey = whiteKeySetProperties(whiteKey: whiteKey)  //sets the properties of the key
            contentViewLayer.insertSublayer(whiteKey, at: 0)      //inserts the sublayer into the content view
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
                    let blackKeyFrame: CGRect = .init(x: whiteKeyFrame.origin.x + whiteKeyFrame.size.width - (CGFloat(widthOfBlackKeys)/2), y: 0, width: CGFloat(widthOfBlackKeys), height: CGFloat(heightOfBlackKeys))
                    var blackKey: CALayer = CALayer()
                    blackKey.frame = blackKeyFrame
                    blackKey = blackKeySetProperties(blackKey: blackKey) //sets the properties of the black keys
                    blackKeyCount += 1
                    contentViewLayer.insertSublayer(blackKey, at: 1)
                }
            }
         whiteKeyCount += 1
        }
    }
    
    
}

