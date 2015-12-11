//
//  ViewController.swift
//  Calculator
//
//  Created by Mark on 15/11/9.
//  Copyright © 2015年 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber = false
    var hasClickADot = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if "." == digit && hasClickADot {
                
            } else if "." == digit && !hasClickADot {
                display.text = display.text! + digit
                hasClickADot = true
            } else if "π" == digit {
                enter()
                display.text = "\(M_PI)"
            } else {
                display.text = display.text! + digit
            }
        } else {
            if "." == digit {
                hasClickADot = true;
            } else {
                hasClickADot = false
            }
            if "π" == digit {
                display.text = "\(M_PI)"
                enter()
            } else {
                userIsInTheMiddleOfTypingANumber = true
                display.text = digit
            }
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let result = brain.performOperation(operation) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    
}

