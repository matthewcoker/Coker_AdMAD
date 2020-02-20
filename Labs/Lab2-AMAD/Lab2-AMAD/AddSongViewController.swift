//
//  AddSongViewController.swift
//  Lab2-AMAD
//
//  Created by Matthew Coker on 2/20/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit

class AddSongViewController: UIViewController {

    
    @IBOutlet weak var songTextField: UITextField!
    var addedSong = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            if songTextField.text?.isEmpty == false {
                addedSong = songTextField.text!
            }
        }
    }
}
