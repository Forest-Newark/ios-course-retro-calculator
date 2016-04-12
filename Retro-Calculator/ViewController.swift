//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Forest on 4/10/16.
//  Copyright © 2016 TreeCoding. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    //Outlets
    
    @IBOutlet weak var  outputLabel: UILabel!
    
    
    //Variables
        //buttonSound Variable , Initialize AVAudioPlayer
    var buttonSound: AVAudioPlayer!
    
        //Number that is being printed to the screen - Stored as a String
    var runningNumber = ""
    
        //"Left" and "Right" side of the equation
    var leftValueString = ""
    var rightValueString = ""
    
        //Set currentOperation using the enum "Operation" accessed at the "Empty" location
    var currentOperation: Operation = Operation.Empty
    
        //Result Value
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //Calling Button Sounds
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        //Try this code (to prevent crashing) Option for "catch"
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError { print(err.debugDescription)
            
        }
        
    }
    
    
    //Actions & Functions
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
            //Grabs the tag of the button pressed and adds it to (+=) the runningNumber var
        runningNumber += "\(btn.tag)"
        
        outputLabel.text = runningNumber
        
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run Math
            
            //A user selected operator, but selected another operator without first entering a number
            if runningNumber != "" {
                
            rightValueString = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValueString)! * Double(rightValueString)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValueString)! / Double(rightValueString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValueString)! - Double(rightValueString)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValueString)! + Double(rightValueString)!)"
            }
            
            leftValueString = result
            outputLabel.text = result
            }
            currentOperation = op
            
        } else {
            //This is the first time and Operator has been pressed
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    
    

}

