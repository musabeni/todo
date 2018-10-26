//
//  CategoryViewController.swift
//  todo
//
//  Created by Musa Beni on 15/10/2018.
//  Copyright © 2018 Musa Beni. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let real = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cells = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cells.textLabel?.text = categoryArray?[indexPath.row].name ?? "No category Found"
        
        return cells
        
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
            
        }
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategry = Category()
            newCategry.name = textField.text!
            
            
            self.save(category: newCategry)
            
        }
        
        alert.addTextField(configurationHandler: { (alertTextField) in
            alertTextField.placeholder = "Add new Category"
            textField = alertTextField
            
            
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save( category: Category){
        do{
            try real.write {
                real.add(category)
            }
        }catch{
            print("fail to save \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(){
        categoryArray = real.objects(Category.self)
        
        tableView.reloadData()
    }
}
