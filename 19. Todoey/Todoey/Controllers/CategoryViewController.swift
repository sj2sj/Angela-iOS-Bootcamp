//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 뜌딩 on 12/7/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

  var categoryArray = [Category]()

  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("context: \(context)")

    loadCategories()
  }

  // MARK: - TableView DataSource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    cell.textLabel?.text = categoryArray[indexPath.row].name
    
    return cell
  }
  
  
  // MARK: - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItmes", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! TodoListViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = categoryArray[indexPath.row]
    }
  }
  
  // MARK: - Data Manipulation Methods
  
  func saveCategories() {
    do {
      try context.save()
    } catch {
      print("카테고리 저장 에러 \(error)")
    }
    
    tableView.reloadData()
  }
  
  func loadCategories() {
    let request: NSFetchRequest<Category> = Category.fetchRequest()
    
    do {
      categoryArray = try context.fetch(request)
    } catch {
      print("카테고리 로드 에러 \(error)")
    }
    
    tableView.reloadData()
  }
  
  // MARK: - Add New Categories
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { action in
      //사용자가 UIAlert에서 항목 추가 버튼을 눌렀을 때
  
      let newCategory = Category(context: self.context)
      newCategory.name = textField.text!
      
      self.categoryArray.append(newCategory)

      self.saveCategories()

    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "새 카테고리 추가"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  
  
 



  
  
}
