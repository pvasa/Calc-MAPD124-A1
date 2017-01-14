//
//  ViewController.swift
//  Calc
//
//  Created by Ryan V on 2017-01-11.
//  Copyright © 2017 Matrians. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var currentOperator: String? = nil
    var firstOperand: String? = nil
    var secondOperand: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 1.0)
        display.minimumScaleFactor = 4/UIFont.labelFontSize
        display.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func digitTouched(_ sender: UIButton) {
        if (display.text == "0") {
            display.text = sender.currentTitle!
        }
        else if (sender.currentTitle! == "." && firstOperand != nil && currentOperator == nil && firstOperand!.contains(".")) {return}
        else if (sender.currentTitle! == "." && secondOperand != nil && secondOperand!.contains(".")) {return}
        else {
            display.text = display.text! + sender.currentTitle!
        }
        if (currentOperator == nil) {
            firstOperand = display.text!
        } else {
            secondOperand = display.text!.components(separatedBy: currentOperator!)[1]
        }
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        if (firstOperand == nil) {return}
        if (secondOperand == nil) {
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
        } else {
            firstOperand = "\(calculate(firstNumber: Double(firstOperand!)!, secondNumber: Double(secondOperand!)!, op: currentOperator!))"
            secondOperand = nil
            currentOperator = sender.currentTitle!
            display.text = firstOperand! + currentOperator!
        }
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        if (firstOperand == nil || currentOperator == nil || secondOperand == nil) {return}
        firstOperand = "\(calculate(firstNumber: Double(firstOperand!)!, secondNumber: Double(secondOperand!)!, op: currentOperator!))"
        currentOperator = nil
        secondOperand = nil
        display.text = firstOperand
    }
    
    @IBAction func acTouched(_ sender: UIButton) {
        display.text = "0"
        currentOperator = nil
        firstOperand = nil
        secondOperand = nil
    }
    
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
