//
//  ChatViewController.swift
//  SwiftChat
//
//  Created by Stefanus Albert Wilson on 9/10/23.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SwiftChat"
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
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
