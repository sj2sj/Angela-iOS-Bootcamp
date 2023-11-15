//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var scoreLabel: UILabel!
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  @IBOutlet weak var choice3Button: UIButton!
  
  var quizBrain = QuizBrain()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateUI()
  }

  @IBAction func answerButtonPressed(_ sender: UIButton) {
    let userAnswer = sender.currentTitle! //True , False
    let userGotItRight = quizBrain.checkAnswer(userAnswer)
    
    if userGotItRight {
      sender.backgroundColor = UIColor.green
    } else {
      sender.backgroundColor = UIColor.red
    }

    quizBrain.nextQuestion()
    
    //반복되지 않기 때문에 (한번만 실행되고 끝나기 때문에)
    //변수에 넣지 않고 바로 실행시키기
    Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    
    //updateUI()
  }
  
  @objc func updateUI() {
    questionLabel.text = quizBrain.getQuestionText()
    progressBar.progress = quizBrain.getProgress()
    scoreLabel.text = "Score: \(quizBrain.getScore())"
    
    let answerText = quizBrain.getAnswerText()
    choice1Button.setTitle(answerText[0], for: .normal)
    choice2Button.setTitle(answerText[1], for: .normal)
    choice3Button.setTitle(answerText[2], for: .normal)
    
    choice1Button.backgroundColor = UIColor.clear
    choice2Button.backgroundColor = UIColor.clear
    choice3Button.backgroundColor = UIColor.clear
  }
  
}

