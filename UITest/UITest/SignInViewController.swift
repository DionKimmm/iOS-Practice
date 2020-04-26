//
//  SignInViewController.swift
//  inflearn_iOS12_signin
//
//  Created by mac on 2020/04/09.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let loginURLString = "http://localhost:3000/loginUsers"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        버튼 외관 꾸미기
//        버튼의 테두리를 네모에서 타원형으로 바꾸기 (곡률을 이용하여)
        buttonSignIn.layer.cornerRadius = buttonSignIn.bounds.size.height / 2
        
        buttonSignIn.layer.borderWidth = 1
        buttonSignIn.layer.borderColor = UIColor.blue.cgColor
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signInAPICall(_ sender: Any) {
        
        //parameters key:value
        //get post
        //URLSession
        
        let param = [
            "userName" : userNameTextField.text ?? "",  // nil 일때는 ?? 뒤의 값
            "password" : passwordTextField.text ?? ""
        ]
        
        //query string key=value & key=value
        param.queryString
        
        //http://localhost:3000/loginUsers
        
        //network
        
        
        // 다음 형태는 ? 때문에 사람이 쉽게 실수할수있는 타입이므로, URLComponents를 사용한다.
        //let loginURL = URL(string: "http://localhost:3000/loginUsers" + "?" + param.queryString)
        
        
        //URLComponents
        var urlComponents = URLComponents(string: loginURLString)
        urlComponents?.query = param.queryString
        
        
        //옵셔널 언래핑 방법 if let vs. guard let
        guard let hasURL = urlComponents?.url else{
            return
        }
        
        
        // network modeling을 하지 않으면 굉장히 복잡해진다.
        // codable를 사용하면 깔끔
        URLSession.shared.dataTask(with: hasURL) { (data, response, error) in
            
        }
    }
    
    
    @IBAction func dismissVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil) 
    }
    
    
    @IBAction func moveToSignUp(_ sender: Any) {
        let signUpVC = UIStoryboard(name: "SignUpVC", bundle: nil).instantiateViewController(identifier: "signUpVC")
        self.navigationController?.pushViewController(signUpVC, animated: true)
        
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

