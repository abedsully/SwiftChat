//
//  LoginsViewController.swift
//  SwiftChat
//
//  Created by Stefanus Albert Wilson on 9/10/23.
//

import UIKit
import FirebaseAuth

class LoginsViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                }
                
                else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
                
            }
            
        }
        
    }
    
    
}
