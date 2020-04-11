//
//  LogInViewController.swift
//  firestoredemo
//
//  Created by App Dev on 2020-04-07.
//  Copyright © 2020 App Dev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()

        // Do any additional setup after loading the view.
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
        Utilities.styleHollowButton(cancelButton)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func validateText() -> String? {
        //Function to check to see if all fields are filled
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in the all fields."
        }
        //Check to see if password follows the rules

        
        return nil
    }
    
    func showError(_ message: String) {
        //Display error function
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToOrigin (){
        //Instantiate a view controller with the name from "Constants.Storyboard.homeViewController" as a HomeViewController type.
        let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ViewController) as? ViewController

        //Set the root view controller to the newly instantiated View controller
        view.window?.rootViewController = ViewController
        //Set the new rootViewController as the visible one.
        view.window?.makeKeyAndVisible()

    }
    
    func transitionToHome (){
        //Instantiate a view controller with the name from "Constants.Storyboard.homeViewController" as a HomeViewController type.
        let HomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        //Set the root view controller to the newly instantiated View controller
        view.window?.rootViewController = HomeViewController
        //Set the new rootViewController as the visible one.
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        
        let emailText = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordText = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (Result, Err) in
            if Err != nil {
                //If there is an error signing up, display the error to the user
                self.showError(Err!.localizedDescription)
            }
            else {
                //Transition to home screen
                self.transitionToHome()
        }
    }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        transitionToOrigin()
    }
    
}
