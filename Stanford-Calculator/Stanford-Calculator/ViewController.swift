//
//  ViewController.swift
//  Stanford-Calculator
//
//  Created by 김동욱 on 22/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        
        //        Optional :: nil(not set) vs set(associated value)
//        let digit = sender.currentTitle  => digit is optional("String")
//        let digit = sender.currentTitle! => digit is String
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
        
    }
//    property
//    내가 값을 물어볼 때마다 디스플레이에 있는 Double을 가져오고
//    값을 설정할 때마다 디스플레이의 값을 설정하겠지
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
//    private var brain: CalculatorBrain = CalculatorBrain()
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
}

