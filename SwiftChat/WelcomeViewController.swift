//
//  ViewController.swift
//  SwiftChat
//
//  Created by Stefanus Albert Wilson on 9/10/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                titleLabel.text = ""
                var charIndex = 0.0
                let titleText = K.appName
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                        self.titleLabel.text?.append(letter)
                    }
                    charIndex += 1
                }
        
    }


    @IBAction func registerButton(_ sender: UIButton) {
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    
}

