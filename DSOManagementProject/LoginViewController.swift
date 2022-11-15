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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func loginPressed(_ sender: UIButton) {
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
                print("Login failed   Error:\(response.error)")
            }
                    
        }
        
    }
    
    func callApi(){
        
    }
    

}

