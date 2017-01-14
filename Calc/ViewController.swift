//
//  ViewController.swift
//  Calc - Simple calculator for iOS
//
//  Created by Ryan V on 2017-01-11.
//  Edited by Ryan V on 2017-01-14.
//  Copyright © 2017 Matrians. All rights reserved.
//

import UIKit

// View controller for Main storyboard
class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel! // Label for displaying stuff
    
    var currentOperator: String? = nil // Currently selected operator by user
    var firstOperand: String? = nil // The first operand
    var secondOperand: String? = nil // The second operand
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set background color of the view to make borders and sides match color of the display
        self.view.backgroundColor = UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 1.0)
        display.minimumScaleFactor = 4/UIFont.labelFontSize
        display.adjustsFontSizeToFitWidth = true
    }
    
    // Called when any of the digits (including ".") is touched
    @IBAction func digitTouched(_ sender: UIButton) {
        if (display.text == "0") {
            display.text = sender.currentTitle!
        }
            
        // Don't allow multiple dots in single operand
        else if (sender.currentTitle! == "." && firstOperand != nil && currentOperator == nil && firstOperand!.contains(".")) {return}
        else if (sender.currentTitle! == "." && secondOperand != nil && secondOperand!.contains(".")) {return}
        else {
            display.text = display.text! + sender.currentTitle!
        }
        // If operator not set, update first operand else, update second operand
        if (currentOperator == nil) {
            firstOperand = display.text!
        } else {
            secondOperand = display.text!.components(separatedBy: currentOperator!)[1]
        }
    }
    
    // Called when any of the operators is touched
    @IBAction func operatorTouched(_ sender: UIButton) {
        if (firstOperand == nil) {return} // Cannot select operator until first operand is nil
        if (secondOperand == nil) {
            // If second operand is nil, either do sqrt or add selected operator to display
            if (currentOperator == nil) {
                currentOperator = sender.currentTitle!
                if (currentOperator! == "√") {
                    firstOperand = "\(calculate(firstNumber: Double(firstOperand!)!, secondNumber: 0, op: currentOperator!))"
                    currentOperator = nil
                    display.text = firstOperand!
                } else {
                    display.text = display.text! + currentOperator!
                }
            } else {
                display.text = display.text!.replacingOccurrences(of: currentOperator!, with: sender.currentTitle!)
                currentOperator = sender.currentTitle!
            }
        // If all is set, do calculation and set answer as first operand, and add new selected operator to that
        } else {
            firstOperand = "\(calculate(firstNumber: Double(firstOperand!)!, secondNumber: Double(secondOperand!)!, op: currentOperator!))"
            secondOperand = nil
            currentOperator = sender.currentTitle!
            display.text = firstOperand! + currentOperator!
        }
    }
    
    // Called when "=" is touched
    @IBAction func equalTouched(_ sender: UIButton) {
        if (firstOperand == nil || currentOperator == nil || secondOperand == nil) {return}
        firstOperand = "\(calculate(firstNumber: Double(firstOperand!)!, secondNumber: Double(secondOperand!)!, op: currentOperator!))"
        currentOperator = nil
        secondOperand = nil
        display.text = firstOperand
    }
    
    // Called when "AC" is touched - reset display and nil all variables
    @IBAction func acTouched(_ sender: UIButton) {
        display.text = "0"
        currentOperator = nil
        firstOperand = nil
        secondOperand = nil
    }
    
    // Applies the passed operator to both operands and returns answer float value
    func calculate(firstNumber: Double, secondNumber: Double, op: String) -> Double {
        switch op {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "×":
            return firstNumber * secondNumber
        case "÷":
            return firstNumber / secondNumber
        case "%":
            return firstNumber.truncatingRemainder(dividingBy: secondNumber)
        case "√":
            return sqrt(firstNumber)
        default:
            return 0
        }
    }
}
