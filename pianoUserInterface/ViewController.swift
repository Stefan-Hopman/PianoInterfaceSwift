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
        
        //finds the height and width of the key we want to use
        let heightKey: Float = Float(contentView.layer.bounds.height)
        let contentViewWidth: Float = Float(contentView.layer.bounds.width)
        let widthKey: Float = contentViewWidth / Float(numberOfKeys)
        addKeys(heightKey: heightKey, widthKey: widthKey)
    }
    
    //MARK: Random Color Function
    func randomColor() -> CGColor{
        let ranRed = CGFloat(drand48()) //generates a random red, green, blue values from 0.0 to 1.0
        let ranGreen = CGFloat(drand48())
        let ranBlue = CGFloat(drand48())
        let ranColor = CGColor(red: ranRed, green: ranGreen, blue: ranBlue, alpha: 1.0)//generates a random color code
        return ranColor
    }
   
    //MARK: Generating Keys
    func addKeys(heightKey: Float, widthKey: Float) {
    
        for _ in 1 ... numberOfKeys {
            let whiteKey : CALayer = CALayer()
            // size and position
            whiteKey.frame.origin.x = CGFloat(xPositionKey) // set the x position
            whiteKey.frame.origin.y = CGFloat(yPositionKey) // set the y position
            whiteKey.frame.size.width = CGFloat(widthKey)   // set the width
            whiteKey.frame.size.height = CGFloat(heightKey) // set the height
            // border properties
            whiteKey.borderColor = randomColor()            // sets the border color
            whiteKey.borderWidth = 5.0                      // sets the border width
            whiteKey.backgroundColor = randomColor()        // sets the border color
            contentViewLayer.addSublayer(whiteKey)          //adding a sublayer to the content view
            xPositionKey += widthKey                        //increases the xposition
        }
    }
}

