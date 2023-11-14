//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by 뜌딩 on 2023/11/14.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var rightImageView: UIImageView!
  @IBOutlet weak var leftImageView: UIImageView!
  
  //message cell 생성 시 실행
  override func awakeFromNib() {
    super.awakeFromNib()
    
    messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
}
