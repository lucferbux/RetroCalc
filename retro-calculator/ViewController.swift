//
//  ViewController.swift
//  retro-calculator
//
//  Created by lucas fernández on 17/03/16.
//  Copyright © 2016 lucas fernández. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //var
    var btnSound: AVAudioPlayer!
    var runningNumber: String = ""
    var leftValStr: String = ""
    var rightValStr: String = ""
    var result: String = ""
    var currentOperation: Operation = Operation.Empty
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    //Outlets
    @IBOutlet weak var outputLbl: UILabel!
    
    
    //Actions
    @IBAction func numberPressed(btn: UIButton){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    
    
    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtactPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        leftValStr = ""
        rightValStr = ""
        result = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
    
    
    //functions
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.play(){
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        //To change navBar to white, also plist View controller-based status bar appearance must be in NO
        
        if let navController = self.navigationController {
            navController.navigationBar.tintColor = self.view.tintColor
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let url = NSURL(fileURLWithPath: path!)
        
        do{
        try btnSound = AVAudioPlayer(contentsOfURL: url)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

