//
//  DetailViewController.swift
//  Lab4-AMAD
//
//  Created by Matthew Coker on 3/4/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var siteDescription = String()
    var siteDirections = String()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    
    override func viewWillAppear (_ animated: Bool) {
        descriptionLabel.text = siteDescription
        directionsLabel.text = siteDirections
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
