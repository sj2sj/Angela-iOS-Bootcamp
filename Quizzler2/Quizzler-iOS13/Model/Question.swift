//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by 뜌딩 on 2023/10/31.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
  let text: String
  let answer: [String]
  let correctAnswer: String
  
  init(q: String, a: [String], correctAnswer: String) {
    text = q
    answer = a
    self.correctAnswer = correctAnswer
  }
}
