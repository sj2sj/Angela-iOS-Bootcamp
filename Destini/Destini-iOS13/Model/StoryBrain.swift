//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct StoryBrain {
  
  let stories = [
    Story(title: "You see a fork in the road.", choice1: "Take a left.", nextDepth1: 1, choice2: "Take a right.", nextDepth2: 2)
    , Story(title: "You see a tiger.", choice1: "Shout for help", nextDepth1: 2, choice2: "Play dead.", nextDepth2: 0)
    , Story(title: "You find a treasure chest.", choice1: "Open it.", nextDepth1: 0, choice2: "Check for traps.", nextDepth2: 0)
  ]
  
  var storyNum = 0 //current story num
  var selectStoryNum = 0
  
  func getStoryTitle() -> String {
    return stories[storyNum].title
  }
  
  func getChoice1Text() -> String {
    return stories[storyNum].choice1
  }
  
  func getChoice2Text() -> String {
    return stories[storyNum].choice2
  }
  
  mutating func nextStory(userChoice: String) {
    if userChoice == stories[storyNum].choice1 { //선택이 1이라면
      storyNum = stories[storyNum].nextDepth1
    } else {
      storyNum = stories[storyNum].nextDepth2
    }
  }
  
}
