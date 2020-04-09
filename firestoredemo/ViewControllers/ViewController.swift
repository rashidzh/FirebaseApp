//
//  ViewController.swift
//  firestoredemo
//
//  Created by App Dev on 2020-04-07.
//  Copyright © 2020 App Dev. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        setupElements()
        //super.viewDidLoad()
        let db = Firestore.firestore()
        // Do any additional setup after loading the view.
        db.collection("wine").addDocument(data: ["firstName": "James", "lastName":"Johnson", "age":38])
    }

    func setupElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(logInButton)
    }

}


