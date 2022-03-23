//
//  LoginController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/23/22.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Variables declaration
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordInvalidLabel: UILabel!
    
    //MARK: - Login functions
    @IBAction func loginButtonClicked(_ sender: Any) {
        NetworkingAPIFunctions.functions.login(username: username.text!, password: password.text!)
    }
    
    static func passwordCorrect(){
        print("GOT HERE")
        
        //DataManager.navigationController?.popViewController(animated: true)
        DataManager.loginController!.username.text = ""
        DataManager.loginController!.password.text = ""
        DataManager.loginController!.dismiss(animated:true, completion: nil)
        NetworkingAPIFunctions.functions.fetchNotes()
        DataManager.viewController!.view.layoutIfNeeded()
    }
    
    static func passwordIncorrect(){
        DataManager.loginController!.passwordInvalidLabel.isHidden = false
        DataManager.loginController!.passwordInvalidLabel.text = "Wrong username or password, please try again"
    }
    
    static func serverUnavailable(){
        DataManager.loginController!.passwordInvalidLabel.isHidden = false
        DataManager.loginController!.passwordInvalidLabel.text = "Server appears to be offline"
    }
    
    //MARK: - View functions
    override func viewWillAppear(_ animated: Bool) {
        passwordInvalidLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
