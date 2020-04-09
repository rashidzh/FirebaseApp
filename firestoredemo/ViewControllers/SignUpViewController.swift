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
        //Syling and Formatting of Buttons and Text fields
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
        //Function to check to see if all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in the all fields."
        }
        //Check to see if password follows the rules
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Password must contain at least 1 special character and must be least 8 characters long."
        }
        
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
    

    @IBAction func signUpTapped(_ sender: Any) {
        
        let isValid = validateText()
        //Check to see if fields filled in are valid
        if isValid != nil {
            showError(isValid!)
        }
        // If everything is valid proceed in creating an account and storing the users name in DB
        else {
            let emailText = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordText = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstNameText = self.firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastNameText = self.lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { (Result, Err) in
                if Err != nil {
                    //If there is an error signing up, display the error to the user
                    self.showError(Err!.localizedDescription)
                }
                else {
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
            }
        }
    
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        transitionToOrigin()
    }
    
}
