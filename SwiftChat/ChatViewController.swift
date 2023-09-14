//
//  ChatViewController.swift
//  SwiftChat
//
//  Created by Stefanus Albert Wilson on 9/10/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    // Reference to Firebase database
    
    let db = Firestore.firestore()
    
    var message: [Message] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
        
    }
    
    func loadMessages(){
        db.collection(K.Firestore.collectionName).order(by: K.Firestore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.message = []
            if let e = error {
                print("There are some issue receiving data from firestore. \(e)")
            }
            
            else{
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        
                        // because the initial class of messageSender is Any?, typecasting to String with (as!) is required
                        if let messageSender = data[K.Firestore.senderField] as? String, let messageBody = data[K.Firestore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.message.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.Firestore.collectionName).addDocument(data: [K.Firestore.senderField: messageSender, K.Firestore.bodyField: messageBody, K.Firestore.dateField: Date().timeIntervalSince1970] ) { (error) in
                if let e = error {
                    print("There is an issue saving data to the firestore, \(e)")
                }
                
                else{
                    print("Successfully sent data")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                    
                }
            }
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    // configure how many row/message in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    // asking which tableview to be displayed in every row of tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messages = message[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell // as for cast the cell to be MessageCell
        cell.label.text = messages.body
        
        if messages.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBubble.backgroundColor = UIColor(named: K.Color.lightPurple)
            cell.label.textColor = UIColor(named: K.Color.black)
        }
        
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            cell.messageBubble.backgroundColor = UIColor(named: K.Color.darkPurple)
            cell.label.textColor = UIColor(named: K.Color.white)
        }
            
            
        return cell
    }
    
}
