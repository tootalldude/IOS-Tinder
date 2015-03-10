//
//  ViewController.swift
//  IOS-Tinder
//
//  Created by Bertrand on 08/03/2015.
//  Copyright (c) 2015 Bertrand Bloc'h. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var loginCancelledLabel: UILabel!
    
    var fbloginView:FBLoginView = FBLoginView(readPermissions: ["email", "public_profile"])
    
    @IBAction func signIn(sender: AnyObject) {
        
        var permissions = ["public_profile"]
        
        self.loginCancelledLabel.alpha = 0
        
        // Update - added ,block:
        
        PFFacebookUtils.logInWithPermissions(permissions, block: {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
                
                self.loginCancelledLabel.alpha = 1
                
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                
                self.performSegueWithIdentifier("signUp", sender: self)
                
            } else {
                self.loginCancelledLabel.alpha = 0
                NSLog("User logged in through Facebook!")
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PFUser.currentUser() != nil {
            
            println("User logged in")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
