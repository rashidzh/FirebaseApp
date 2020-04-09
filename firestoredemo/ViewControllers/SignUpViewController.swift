//
//  SignUpViewController.swift
//  firestoredemo
//
//  Created by App Dev on 2020-04-07.
//  Copyright © 2020 App Dev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        // Do any additional setup after loading the view.
        
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
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
        
        //Check to see if all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Error, please fill in the all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Password not secure enough."
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome (){
        let HomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = HomeViewController
        view.window?.makeKeyAndVisible()
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
    var isValid = validateText()
        if isValid != nil {
            showError(isValid!)
        }
        else {
            let emailText = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordText = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstNameText = self.firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastNameText = self.lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { (Result, Err) in
                if Err == nil {
                    let db = Firestore.firestore()

                    var ref: DocumentReference? = nil
                    ref = db.collection("users").addDocument(data: [
                        "first": firstNameText,
                        "last": lastNameText,
                        "UID": Result!.user.uid
                    ])
                    
                    //Transition to home screen
                    self.transitionToHome()
                }
                else {
                    self.showError("Error for some reason")
                }
            }
        }
    
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
    }
    
    
}
