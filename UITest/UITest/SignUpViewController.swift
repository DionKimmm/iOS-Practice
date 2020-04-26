//
//  SignUpViewController.swift
//  Inflearn_iOS12_signin
//
//  Created by mac on 2020/04/10.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonSignUp.layer.cornerRadius = buttonSignUp.bounds.height / 2
        buttonSignUp.layer.borderWidth = 1
        buttonSignUp.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBOutlet weak var buttonSignUp: UIButton!
    
    @IBAction func popVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
