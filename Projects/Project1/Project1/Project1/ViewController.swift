//
//  ViewController.swift
//  Project1
//
//  Created by Matthew Coker on 3/5/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var itemTableView: UITableView!
    var items: [String] = ["Get Groceries", "Get N94", "Hit the gym"]

    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            itemTableView.delegate = self
            itemTableView.dataSource = self
            itemTableView.rowHeight = 80
        }
        
        
    @IBAction func addItem(_ sender: Any) {
        let itemAlert = UIAlertController(title: "Add Item", message: "Add a new Item", preferredStyle: .alert)
        
        itemAlert.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = itemAlert.textFields![0]
            self.items.append(newItem.text!)
            self.itemTableView.reloadData()
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        itemAlert.addAction(addItemAction)
        itemAlert.addAction(cancelAction)
        
        present(itemAlert, animated: true, completion: nil)
    }
    
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
            
            cell.itemLabel.text = items[indexPath.row]
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! ItemCell
            
            if cell.isChecked == false {
                cell.checkMark.image = UIImage(named: "checkMark.png")
                cell.isChecked = true
                let ref = Database.database().reference(withPath: "items").child("DZX0J9scxYRhp1MuEyLF").child(items[indexPath.row])
                ref.updateChildValues(["IsChecked": true])
            }
            else {
                cell.checkMark.image = nil
                cell.isChecked = false
                let ref = Database.database().reference(withPath: "items").child("DZX0J9scxYRhp1MuEyLF").child(items[indexPath.row])
                ref.updateChildValues(["IsChecked": false])
            }
            
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                items.remove(at: indexPath.row)
                itemTableView.reloadData()
            }
        }
    }

