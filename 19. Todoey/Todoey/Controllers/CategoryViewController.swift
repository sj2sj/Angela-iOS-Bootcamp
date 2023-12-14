//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 뜌딩 on 12/7/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

  let realm = try! Realm()
  
  var categories: Results<Category>?

  
  override func viewDidLoad() {
    super.viewDidLoad()

    loadCategories()
    
    tableView.rowHeight = 80.0
    tableView.separatorStyle = .none
  }
  
  override func viewWillAppear(_ animated: Bool) {
    guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
    
    navBar.backgroundColor = UIColor(hexString: "1D9BF6")
  }

  // MARK: - TableView DataSource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
    if let category = categories?[indexPath.row] {
      cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
      
      guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
      
      cell.backgroundColor = categoryColor
      cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
    }
    
    
 
    return cell
  }

  
  
  // MARK: - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItmes", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! TodoListViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = categories?[indexPath.row]
    }
  }
  
  // MARK: - Data Manipulation Methods
  
  func save(category: Category) {
    do {
      try realm.write {
        realm.add(category)
      }
    } catch {
      print("카테고리 저장 에러 \(error)")
    }
    
    tableView.reloadData()
  }
  
  func loadCategories() {
    categories = realm.objects(Category.self)
  
    tableView.reloadData()
  }
  
  
  // MARK: - Delete Data From Swipe
  
  override func updateModel(at indexPath: IndexPath) {
    if let categoryForDeletion = self.categories?[indexPath.row] {
     do {
       try self.realm.write {
         self.realm.delete(categoryForDeletion)
       }
     } catch {
       print("Error Item Delete \(error)")
      }
    }
  }
  

  
  // MARK: - Add New Categories
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { action in
      //사용자가 UIAlert에서 항목 추가 버튼을 눌렀을 때
  
      let newCategory = Category()
      newCategory.name = textField.text!
      newCategory.color = UIColor.randomFlat().hexValue()
      
      self.save(category: newCategory)

    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "새 카테고리 추가"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
}
