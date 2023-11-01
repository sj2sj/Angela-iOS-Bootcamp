//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by 뜌딩 on 2023/11/02.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var settingsLabel: UILabel!
  
  var result = ""
  var people = 0
  var tip = 10
  
  override func viewDidLoad() {
    super.viewDidLoad()

    totalLabel.text = result
    settingsLabel.text = "Split between \(people), with \(tip)% tip."
  }
    

  @IBAction func recalculatePressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
