//
//  ViewController.swift
//  Lab5-AMAD
//
//  Created by Matthew Coker on 3/18/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    var uid: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButton(_ sender: Any) {
        
        if userNameTextField.text != nil && passWordTextField != nil {
            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passWordTextField.text!) { (result, error) in
                if error != nil {
                    print("There was an error")
                }
                else {
                    self.uid = (result?.user.uid)!
                    let ref = Database.database().reference(withPath: "users").child(self.uid)
                    ref.setValue(["username" : self.userNameTextField.text!])
                    ref.setValue(["password": self.passWordTextField.text!])
                }
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        if userNameTextField.text != nil && passWordTextField.text != nil {
            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passWordTextField.text!) { (result, error) in
                if error != nil {
                    print ("Thats not good!")
                }
                else {
                    self.uid = (result?.user.uid)!
                    
                }
            }
        }
    }
    
    
}

