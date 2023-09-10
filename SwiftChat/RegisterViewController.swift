//
//  RegisterViewController.swift
//  SwiftChat
//
//  Created by Stefanus Albert Wilson on 9/10/23.
//

import UIKit
import FirebaseAuth
import Firebase


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e)

                    }
                    
                    else {
                        self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    }
                    
                }
            }
    }
    
}
