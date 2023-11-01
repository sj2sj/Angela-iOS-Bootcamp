//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by 뜌딩 on 2023/11/01.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
  var bmi: BMI?
  
  func getBmiValue() -> String {
    let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
    return bmiTo1DecimalPlace
  }
  
  func getAdvice() -> String {
    return bmi?.advice ?? "no advice"
  }
  
  func getColor() -> UIColor {
    return bmi?.color ?? .clear
  }
  
  mutating func calculateBMI(height: Float, weight: Float) {
    let bmiValue = weight / pow(height, 2)

    if bmiValue < 18.5 {
      bmi = BMI(value: bmiValue, advice: "Eat more cookies!", color: .blue)
    } else if bmiValue < 24.9 {
      bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: .green)
    } else {
      bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: .red)
    }
  }
  
}
