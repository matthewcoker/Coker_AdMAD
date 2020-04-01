//
//  TodoList.swift
//  Lab5-AMAD
//
//  Created by Matthew Coker on 3/31/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

struct Item {
    var isChecked: Bool
    var itemName: String
}


class TodoList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    var items: [Item] = []
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWelcomeLabel()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.rowHeight = 80
        
        if let uid = userID {
            userLabel.text = uid
        }
        
        loadItems()
        
    }
    
    
    
    func setWelcomeLabel() {
        let userRef = Database.database().reference(withPath: "users").child(userID!)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value!["username"] as? String
            self.userLabel.text = "Hello " + username! + "!"
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        let itemAlert = UIAlertController(title: "New Item", message: "Add a todo", preferredStyle: .alert)
        
        itemAlert.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default){ (action) in
            let itemText = itemAlert.textFields![0].text
            self.items.append(Item(isChecked: false, itemName: itemText!))
            
            let ref = Database.database().reference(withPath: "users").child(self.userID!).child("items")
            ref.child(itemText!).setValue(["isChecked": false])
            
            self.todoTableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        
        itemAlert.addAction(addItemAction)
        itemAlert.addAction(cancel)
        
        present(itemAlert, animated: true, completion: nil)
        
    }
    
    func loadItems() {
        let ref = Database.database().reference(withPath: "users").child(userID!).child("items")
        
        ref.observeSingleEvent(of: .value ){ (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let itemName = child.key
                let itemRef = ref.child(itemName)
                itemRef.observeSingleEvent(of: .value, with: { (todoSnapshot) in
                    let value = todoSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    self.items.append(Item(isChecked: isChecked!, itemName: itemName))
                    self.todoTableView.reloadData()
                    
                })
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath) as! ItemCell
        
        cell.ItemLabel.text = items[indexPath.row].itemName
        
        if items[indexPath.row].isChecked {
            cell.checkMark.image = UIImage(named: "checkMark.png")
        }
        else {
            cell.checkMark.image = nil
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "users").child(userID!).child("items").child(items[indexPath.row].itemName)
        
        if items[indexPath.row].isChecked {
            items[indexPath.row].isChecked = false
            ref.updateChildValues(["isChecked": false])
        }
        else {
            items[indexPath.row].isChecked = true
            ref.updateChildValues(["isChecked": true])
        }
        
        todoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = Database.database().reference(withPath: "users").child(userID!).child("items").child(items[indexPath.row].itemName)
            
            ref.removeValue()
            items.remove(at: indexPath.row)
            todoTableView.reloadData()
        }
    }
    
    
    
}
