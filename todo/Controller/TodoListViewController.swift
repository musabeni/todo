//
//  ViewController.swift
//  todo
//
//  Created by Musa Beni on 02/10/2018.
//  Copyright © 2018 Musa Beni. All rights reserved.
//

import UIKit
import  RealmSwift


class TodoListViewController: UITableViewController  {
    
    
    
    var todoItem: Results<Item>?
    let real = try! Realm()
    
    var selectedCategory: Category?{
        didSet{
             loadItems()
        }
    }
   
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let item = defaults.array(forKey: "toDolistArray") as? [String]{
//            itemArray = item
//        }
       
        
//        print(dataFilePath)
        
//        let newItem = Items()
//        newItem.title = "musa beni"
////        newItem.done = true
//        itemArray.append(newItem)
//        
//        let newItem2 = Items()
//        newItem2.title = "namana musa"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Items()
//        newItem3.title = "Dhureha"
//        itemArray.append(newItem3)
        
       
        
//        if let items = defaults.array(forKey: "toDolistArray") as? [Items]{
//            itemArray = items
//        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celles = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        if let item = todoItem?[indexPath.row]{
             celles.textLabel?.text = item.title
            
            celles.accessoryType = item.dane ? .checkmark : .none
        }else{
            celles.textLabel?.text = "no item added"
        }
        
       
        
//        celles.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            celles.accessoryType = .checkmark
//        }else{
//            celles.accessoryType = .none
//        }
        
        
        
        
        return celles
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItem?[indexPath.row]{
            do{
            try real.write {
                //real.delete(item)
                item.dane = !item.dane
            }
            }catch{
                print("Error updating \(error)")
            }
            
        }
        
        tableView.reloadData()
        
        
//        print(itemArray[indexPath.row])
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       // saveItem()
        
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
      
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
       let alert =  UIAlertController(title: "Add new todoitem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            if let currentCategory = self.selectedCategory{
                do{
                try self.real.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.datecreated = Date()
                    currentCategory.item.append(newItem)
                }
                }catch{
                    print("error \(error)")
                }
            }
            
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
    

    
    func loadItems(){
      todoItem = selectedCategory?.item.sorted(byKeyPath: "title", ascending: true)

         tableView.reloadData()

    }


}

extension TodoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItem = todoItem?.filter("title CONTAINS[cd] %@", searchBar.text ?? "title").sorted(byKeyPath: "datecreated", ascending: true)
        
        tableView.reloadData()
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        print(searchBar.text ?? "test")
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text ?? "test")
////       request.predicate = predicate
//
//        let sortDiscriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDiscriptor]
//
//        loadItems(with: request, predicate: predicate)
//
////        do{
////            itemArray = try context.fetch(request)
////        }catch{
////            print("Fail to retrive data \(error)")
////        }



    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }


    }
}

