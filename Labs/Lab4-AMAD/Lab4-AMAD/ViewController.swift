//
//  ViewController.swift
//  Lab4-AMAD
//
//  Created by Matthew Coker on 3/4/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let stateOptions = [ "CO" , "CA" , "FL" , "NM" , "UT" ]
    var selectedState = String()
    var parkDC = ParkDataController()
    var data = [Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedState = stateOptions[0]
        parkDC.onDataUpdate = {[weak self] (data:[Park]) in self?.searchDone(parks: data)}
    }
    
    @IBAction func searchParks(_ sender: Any) {
        do {
            //start loading the data
            try parkDC.loadJson(stateCode: selectedState)
            //block user events and show spinner while fetching the campsites
            let alert = UIAlertController (title: nil , message: "Searching in \(selectedState) ..." , preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView (frame: CGRect (x: 0 , y: 5 , width: 50 , height: 50 ))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView . Style .medium
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true , completion: nil )
        } catch {
            print (error)
        }
    }

    func searchDone(parks: [Park]) {
        //dismiss the loading alery
        dismiss(animated: true , completion: nil )
        //set data property
        data = parks
        performSegue(withIdentifier: "SearchResults", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check id of segue
        if segue.identifier == "SearchResults" {
            //downcast destination vc
            let resultsVC = segue.destination as! ResultsViewController
            //set the title
            resultsVC.title = "\(selectedState) Parks"
            //pass the data
            resultsVC.results = data
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = stateOptions[row]
    }

}

