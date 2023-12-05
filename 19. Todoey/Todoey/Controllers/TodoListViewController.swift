//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

  var itemArray = [Item]()

  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  override func viewDidLoad() {
    super.viewDidLoad()

    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    loadItems()
  }

  
  // MARK: - TableView Datasource Methods

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    let item = itemArray[indexPath.row]
    
    cell.textLabel?.text = item.title
    
    //삼항연산자 value = condition ? valueIfTrue : valueIfFalse
    cell.accessoryType = item.done ? .checkmark : .none
    
    /*
    if item.done == true {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
     */
    
    return cell
  }
  
  
  // MARK: - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(itemArray[indexPath.row])

    //순서가 중요함
    //context.delete(itemArray[indexPath.row])
    //itemArray.remove(at: indexPath.row)
    
    
    //밑의 5줄을 한번에
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    /*
    if itemArray[indexPath.row].done == false {
      itemArray[indexPath.row].done = true
    } else {
      itemArray[indexPath.row].done = false
    }
    */
    
    self.saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)
  }

  
  // MARK: - Add New Items

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { action in
      //사용자가 UIAlert에서 항목 추가 버튼을 눌렀을 때
  
      let newItem = Item(context: self.context)
      newItem.title = textField.text!
      newItem.done = false
      
      self.itemArray.append(newItem)

      self.saveItems()

    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "새 항목 추가"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  
  func saveItems() {

    do {
      try context.save()
    } catch {
     print("Error saving context \(error)")
    }
    
    tableView.reloadData()
  }
  
  
  func loadItems() {
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    do {
      itemArray = try context.fetch(request)
    } catch {
      print("Error fetching data from context \(error)")
    }
  }
  
  
}

