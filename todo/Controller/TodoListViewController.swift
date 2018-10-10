//
//  ViewController.swift
//  todo
//
//  Created by Musa Beni on 02/10/2018.
//  Copyright © 2018 Musa Beni. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Items] ()
    
    let defaults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let item = defaults.array(forKey: "toDolistArray") as? [String]{
//            itemArray = item
//        }
        
        let newItem = Items()
        newItem.title = "musa beni"
//        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Items()
        newItem2.title = "namana musa"
        itemArray.append(newItem2)
        
        let newItem3 = Items()
        newItem3.title = "Dhureha"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "toDolistArray") as? [Items]{
            itemArray = items
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celles = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        celles.textLabel?.text = itemArray[indexPath.row].title
        
        celles.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            celles.accessoryType = .checkmark
//        }else{
//            celles.accessoryType = .none
//        }
        
        
        
        
        return celles
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else{
//            itemArray[indexPath.row].done = false
//        }
        
       
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
       let alert =  UIAlertController(title: "Add new todoitem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Items()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "toDolistArray")
            
          
            
            self.tableView.reloadData()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add item"
            print(alertTextField.text!)
            textField = alertTextField
          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

