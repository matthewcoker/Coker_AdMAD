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
                    ref.setValue(["username" : self.userNameTextField.text!, "password": self.passWordTextField.text!])
                    self.performSegue(withIdentifier: "signInSegue", sender: self)
                }
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        if userNameTextField.text != nil && passWordTextField.text != nil {
            Auth.auth().signIn(withEmail: userNameTextField.text!, password: passWordTextField.text!) { (result, error) in
                if error != nil {
                    print ("Thats not good!")
                }
                else {
                    self.uid = (result?.user.uid)!
                    self.performSegue(withIdentifier: "signInSegue", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let todoListController = nav.topViewController as! TodoList
        todoListController.userID = uid
    }
}

