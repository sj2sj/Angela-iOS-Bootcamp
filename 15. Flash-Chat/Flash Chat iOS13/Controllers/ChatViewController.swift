//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  let db = Firestore.firestore()
  
  var messages: [Message] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    
    title = "⚡️FlashChat"
    navigationItem.hidesBackButton = true
    
    tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    
    loadMessage()
  }
  
  //메시지 로드
  func loadMessage() {
    db.collection(K.FStore.collectionName)
      .order(by: K.FStore.dateField)
      .addSnapshotListener() { (querySnapshot, err) in
        
      self.messages = []
        
      if let e = err {
        print("Firestore에서 데이터 로드 실패, \(e)")
      } else {
        if let qs = querySnapshot?.documents {
          for doc in qs {
            let data = doc.data()
            if let messageSender = data[K.FStore.senderField] as? String
                , let messageBody = data[K.FStore.bodyField] as? String {
              let newMessage = Message(sender: messageSender, body: messageBody)
              self.messages.append(newMessage)
              
              //UI조작 시 습관적으로 메인큐에서!!
              DispatchQueue.main.async {
                self.tableView.reloadData()
                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
              }
            }
          }
        }
      }
    }
  }
  
  
  
  @IBAction func sendPressed(_ sender: UIButton) {
    if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
      db.collection(K.FStore.collectionName).addDocument(data: [
        K.FStore.senderField : messageSender
        , K.FStore.bodyField : messageBody
        , K.FStore.dateField : Date().timeIntervalSince1970
      ]) { (error) in
        if let e = error {
          print("Firestore에 데이터를 저장하는 중 문제 발생, \(e)")
        } else {
          print("데이터 저장 성공")
          self.messageTextfield.text = ""
        }
      }
    }
  }
  
  
  @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      navigationController?.popToRootViewController(animated: true) //가장 루트로 감
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
  }
  
}



extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let message = messages[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
    cell.label?.text = message.body
    
    //현재 사용자 (나) 가 보낸 메세지?
    if message.sender == Auth.auth().currentUser?.email {
      cell.leftImageView.isHidden = true
      cell.rightImageView.isHidden = false
      cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
      cell.label.textColor = UIColor(named: K.BrandColors.purple)
    } else { //다른 사용자가 보낸 메시지
      cell.leftImageView.isHidden = false
      cell.rightImageView.isHidden = true
      cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
      cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
    }
    
    
    
    return cell
  }
  
}


