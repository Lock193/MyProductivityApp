//
//  LoginController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/23/22.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        NetworkingAPIFunctions.functions.login(username: username.text!, password: password.text!)
    }
    
    static func passwordCorrect(){
        print("GOT HERE")
        
        //DataManager.navigationController?.popViewController(animated: true)
        DataManager.loginController!.username.text = ""
        DataManager.loginController!.password.text = ""
        DataManager.loginController!.dismiss(animated:true, completion: nil)
    }
    
    static func passwordIncorrect(){
        DataManager.loginController!.passwordInvalidLabel.isHidden = false
    }
    
    @IBOutlet weak var passwordInvalidLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        passwordInvalidLabel.isHidden = true
        //DataManager.navigationController?.view.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
