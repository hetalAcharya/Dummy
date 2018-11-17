//
//  RegisterViewController.swift
//  viewusingmodelclass
//
//  Created by Kush on 23/09/17.
//  Copyright © 2017 bansi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK:- Outlates
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    //MARK:- viewcontroller override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button actions
    @IBAction func btnRegisterClick(_ sender: Any) {
        requestForRegister()
    }

    private func requestForRegister() {
        
        let url = URL(string: "http://192.168.1.15:8080/iOS_WS/readData.php")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "contentType")        
        
        let params = ["uname":txtEmail.text!,
                      "pwd":txtPassword.text!,
                      "no":txtNumber.text!,
                      "address":txtAddress.text!]
        
        let requestData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        request.httpBody = requestData
        
       let task = URLSession.shared.dataTask(with: request) { (result, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            let resultDict = try! JSONSerialization.jsonObject(with: result!, options: .allowFragments)
            
            print(resultDict)
            
        }
        
        task.resume()
    }
}
