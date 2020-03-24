//
//  ViewController.swift
//  Stanford-Calculator
//
//  Created by 김동욱 on 22/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction func touchDigit(sender: UIButton) {
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
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            if mathematicalSymbol == "pi" {
                display.text = String(M_PI)
            }
        }
    }
    
}

