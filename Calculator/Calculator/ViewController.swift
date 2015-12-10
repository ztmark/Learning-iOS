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
        switch operation {
        case "+": performOperation {$0 + $1}
        case "-": performOperation {$1 - $0}
        case "×": performOperation {$0 * $1}
        case "∕": performOperation {$1 / $0}
        case "√": performOperation {sqrt($0)}
        case "cos": performOperation({ cos($0)})
        case "sin": performOperation({ sin($0)})
        default: break
        }
    }
    
    private func performOperation(operate: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operate(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }

    }
    
    func performOperation(operate: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operate(operandStack.removeLast())
            enter()
        }
        
    }
    
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
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

