//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

  var todoItems: Results<Item>?
  let realm = try! Realm()
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var selectedCategory: Category? {
    didSet {
      loadItems()
    }
  }

 
  override func viewDidLoad() {
    super.viewDidLoad()

    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
    tableView.separatorStyle = .none
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let colorHex = selectedCategory?.color {
      title = selectedCategory!.name
      
      guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
      
      if let navBarColor = UIColor(hexString: colorHex) {
        navBar.backgroundColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
        
        searchBar.barTintColor = navBarColor
      }
    }
    
  }

  
  // MARK: - TableView Datasource Methods

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

    if let item = todoItems?[indexPath.row] {
      cell.textLabel?.text = item.title

      if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage:CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
      }
      
      //삼항연산자 value = condition ? valueIfTrue : valueIfFalse
      cell.accessoryType = item.done ? .checkmark : .none
    } else {
      print("asfasf")
      cell.textLabel?.text = "No Items Added"
    }
    
    return cell
  }
  
  
  // MARK: - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let item = todoItems?[indexPath.row] {
      do {
        try realm.write {
          //realm.delete(item) //데이터 삭제
          item.done = !item.done
        }
      } catch {
        print("Error \(error)")
      }
    }
    
    tableView.reloadData()
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK: - Delete Data From Swipe
  
  override func updateModel(at indexPath: IndexPath) {
    if let deleteItem = self.todoItems?[indexPath.row] {
     do {
       try self.realm.write {
         self.realm.delete(deleteItem)
       }
     } catch {
       print("Error Item Delete \(error)")
      }
    }
  }

  
  // MARK: - Add New Items

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { action in
      //사용자가 UIAlert에서 항목 추가 버튼을 눌렀을 때
  
      if let currentCategory = self.selectedCategory {
        do {
          try self.realm.write {
            let newItem = Item()
            newItem.title = textField.text!
            newItem.dateCreated = Date()
            currentCategory.items.append(newItem)
          }
        } catch {
          print("Error save \(error)")
        }

      }
      
      self.tableView.reloadData()

    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "새 항목 추가"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  func loadItems() {
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    tableView.reloadData()

  }
  

}


// MARK: - Search Bar Method

extension TodoListViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    tableView.reloadData()
    
//    let request: NSFetchRequest<Item> = Item.fetchRequest()
//    
//    let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//    
//    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//    loadItems(with: request, predicate: predicate)
  }
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      loadItems()
      
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }

    }
  }
}
