//
//  ViewController.swift
//  Calc
//
//  Created by Talia Quartetti on 7/5/16.
//  Copyright © 2016 Talia Quartetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBOutlet weak var formulaDisplay: UILabel!
    
    private var topDisplay : String {
        get {
            return description
        }
        set {
            formulaDisplay.text = String(description)
        }
    }
  
    
    private var userIsTyping = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsTyping = true
    }
   
  
    
    var savedProgram: calculatorBrain.PropertyList?
    
    
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    @IBAction func clear() {
        brain.clear()
    }
    
    
    @IBAction func addVariable(sender: UIButton) {
    }
    
    
    
    @IBAction func useVariable(sender: UIButton) {
    }
    
    private var brain = calculatorBrain()
   
    @IBAction private func performOperation(sender: UIButton) {
        if userIsTyping{
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }

}




