//
//  ViewController.swift
//  Calc
//
//  Created by Ryan V on 2017-01-11.
//  Copyright © 2017 Matrians. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    @IBOutlet weak var display: UILabel!
    
    var currentOperator: String? = nil
    var firstOperand: String? = nil
    var secondOperand: String? = nil
    
    @IBAction func digitTouched(_ sender: UIButton) {
        if (display.text == "0") {
            display.text = sender.currentTitle!
        }
        else {
            display.text = display.text! + sender.currentTitle!
        }
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        if (currentOperator == nil) {
            currentOperator = "\(sender.currentTitle!)"
            display.text = display.text! + currentOperator!
        } else {
            display.text = display.text!.replacingOccurrences(of: currentOperator!, with: "\(sender.currentTitle!)")
            currentOperator = "\(sender.currentTitle!)"
        }
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        let operands = display.text!.components(separatedBy: currentOperator!)
        display.text = "\(calculate(firstNumber: Double(operands[0])!, secondNumber: Double(operands[1])!, op: currentOperator!))"
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
        case "x":
            return firstNumber * secondNumber
        case "/":
            return firstNumber / secondNumber
        default:
            return 0
        }
    }
}
