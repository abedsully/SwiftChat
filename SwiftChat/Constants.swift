//
//  Constants.swift
//  SwiftChat
//
//  Created by Stefanus Albert Wilson on 9/10/23.
//

struct K{
    static let appName = "SwiftChat"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    
    struct Firestore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
