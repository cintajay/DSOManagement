//
//  ViewController.swift
//  DSOManagementProject
//
//  Created by user193960 on 11/14/22.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var token = ""

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailPasswordErrorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    //MARK: IBAction Functions
    @IBAction func loginPressed(_ sender: UIButton) {
        if (validate()){
            callApi()
        }
    }
    
    @IBAction func passwordShowHidePressed(_ sender: UIButton) {
        if(passwordTextField.isSecureTextEntry)
        {
            let image = UIImage(named: "icon_show_pass_not")
            sender.setImage(image, for: .normal)
        }
        else{
            let image = UIImage(named: "icon_show_pass")
            sender.setImage(image, for: .normal)
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    //MARK: TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        if textField == usernameTextField{
            if((usernameTextField.text?.isValidEmail())!){
                emailPasswordErrorText.text = ""
                passwordTextField.becomeFirstResponder()
            }
            else {
                emailPasswordErrorText.text = INVALID_EMAIL_TEXT
            }
        } else {
            if(validate()) {
                textField.endEditing(true) //to remove keyboard if both email and password valid
                callApi()
            }
        }
        return true
    }
       
    //MARK: Functions
    func validate() -> Bool
    {
        var valid = true;
        var passwordError: String = ""
        var emailError: String = ""
        if(usernameTextField.text?.count == 0){
            emailError = EMAIL_REQUIRED_TEXT
            valid = false;
        } else {
            if((usernameTextField.text?.isValidEmail())!){
            } else {
                emailError = INVALID_EMAIL_TEXT
                valid = false;
            }
        }
        if((passwordTextField.text?.count)! < 6){
            passwordError = PASSWORD_MININUM_REQ_6_TEXT
            valid = false;
        }
        if(passwordTextField.text?.count == 0){
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
        let login = LoginModel(username: usernameTextField.text! , password: passwordTextField.text!)
        AF.request(loginUrl,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate().responseDecodable(of: ResponseModel.self) { response in
            if let resp = response.value {
                print(resp.response)
                self.token = resp.response
                //self.showNextScreen()
                self.performSegue(withIdentifier: "goToDSOSelection", sender: self)
            }
            else {
                print("Login failed Error:\(response.error)")
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}

