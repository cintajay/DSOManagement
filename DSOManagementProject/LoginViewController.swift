//
//  ViewController.swift
//  DSOManagementProject
//
//  Created by user193960 on 11/14/22.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    let baseUrl = "https://s2pro.orthofx.com/smylio-admin/admin/v1/tokens/login"
    var token = ""

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailPasswordErrorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func loginPressed(_ sender: UIButton) {
        if (validate()){
            callApi()
        }
    }
    func validate() -> Bool
    {
        var valid = true;
        var passwordError: String = ""
        var emailError: String = ""
        if(userName.text?.count == 0){
            emailError = EMAIL_REQUIRED_TEXT
            valid = false;
        } else {
            if((userName.text?.isValidEmail())!){
            } else {
                emailError = INVALID_EMAIL_TEXT
                valid = false;
            }
        }
        if((password.text?.count)! < 6){
            passwordError = PASSWORD_MININUM_REQ_6_TEXT
            valid = false;
        }
        if(password.text?.count == 0){
            passwordError = PASSWORD_REQUIRED_TEXT
            valid = false;
        }
        
        if passwordError == PASSWORD_REQUIRED_TEXT && emailError == EMAIL_REQUIRED_TEXT {
            emailPasswordErrorText.text = EMAIL_PASSWORD_REQ_TEXT
        } else if emailError == INVALID_EMAIL_TEXT {
            emailPasswordErrorText.text = INVALID_EMAIL_TEXT
        } else {
            if emailError != ""{
                emailPasswordErrorText.text = emailError
           } else {
                emailPasswordErrorText.text = passwordError
            }
        }
        return valid;        
    }
    
    func callApi(){
        let login = LoginModel(username: userName.text! , password: password.text!)
        AF.request(baseUrl,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate().responseDecodable(of: ResponseModel.self) { response in
            if let resp = response.value {
                print(resp.response)
                self.token = resp.response
            }
            else {
                print("Login failed Error:\(response.error)")
            }
        }
    }
    

}

