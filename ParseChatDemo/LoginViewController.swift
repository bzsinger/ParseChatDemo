//
//  LoginViewController.swift
//  ParseChatDemo
//
//  Created by Benny Singer on 12/6/17.
//  Copyright © 2017 bzsinger. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        if checkEmpty() {
            showAlert(error: "Empty username/password fields")
            return
        }
        registerUser()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if checkEmpty() {
            showAlert(error: "Empty username/password fields")
            return
        }
        loginUser()
    }
    
    func registerUser() {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if error != nil {
                self.showAlert(error: "User signup failed. Use another username.")
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }   
    }
    
    func loginUser() {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if error != nil {
                self.showAlert(error: "User login failed. Check your username/password and try again.")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }   
    }
    
    func checkEmpty() -> Bool {
        if usernameTextField.text == nil || passwordTextField.text == nil || usernameTextField.text!.trimmingCharacters(in: .whitespaces).characters.count == 0 || passwordTextField.text!.trimmingCharacters(in: .whitespaces).characters.count == 0 {
            return true
        }
        return false
    }
    
    func showAlert(error: String) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
