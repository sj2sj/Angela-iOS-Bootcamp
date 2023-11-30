//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var itemArray = [Item]()
  
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newItem = Item()
    newItem.title = "마이크 찾기"
    itemArray.append(newItem)
    
    let newItem2 = Item()
    newItem2.title = "노래 하기"
    itemArray.append(newItem2)

    let newItem3 = Item()
    newItem3.title = "물 사기"
    itemArray.append(newItem3)
    
    if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
      itemArray = items
    }

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
    
    //밑의 5줄을 한번에
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    /*
    if itemArray[indexPath.row].done == false {
      itemArray[indexPath.row].done = true
    } else {
      itemArray[indexPath.row].done = false
    }
    */
    
    tableView.reloadData()

    tableView.deselectRow(at: indexPath, animated: true)
  }

  
  // MARK: - Add New Items

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { action in
      //사용자가 UIAlert에서 항목 추가 버튼을 눌렀을 때
      
      let newItem = Item()
      newItem.title = textField.text!
      
      self.itemArray.append(newItem)
      
      self.defaults.set(self.itemArray, forKey: "TodoListArray")
      
      self.tableView.reloadData()
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "새 항목 추가"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  
}
