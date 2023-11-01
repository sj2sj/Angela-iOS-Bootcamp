//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

  @IBOutlet weak var billTextField: UITextField!
  @IBOutlet weak var zeroPctButton: UIButton!
  @IBOutlet weak var tenPctButton: UIButton!
  @IBOutlet weak var twentyPctButton: UIButton!
  @IBOutlet weak var splitNumberLabel: UILabel!

  var tip: Float = 0.1
  var numOfpeople: Int = 2
  var resultBill: String = ""
  
  //팁버튼
  @IBAction func tipChanged(_ sender: UIButton) {
    zeroPctButton.isSelected = false
    tenPctButton.isSelected = false
    twentyPctButton.isSelected = false
    
    sender.isSelected = true
    
    tip = Float(String(sender.currentTitle!.dropLast()))!/100
    
    billTextField.endEditing(true)

  }
  
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    numOfpeople = Int(sender.value)
    splitNumberLabel.text = String(numOfpeople)
    
  }
  
  
  @IBAction func calculatePressed(_ sender: UIButton) {
    if billTextField.text != "" {
      let bill = Float(billTextField.text!)!
      let result = (bill + (bill * tip)) / Float(numOfpeople)
      resultBill = String(format: "%.2f", result)
      self.performSegue(withIdentifier: "goToResult", sender: self)
    }
  
    
    
    
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToResult" {
      let destinationVC = segue.destination as! ResultsViewController
      destinationVC.result = resultBill
      destinationVC.people = numOfpeople
      destinationVC.tip = Int(tip*100)
    }
  }
  

}

