//
//  signUpViewController.swift
//  IOS-Tinder
//
//  Created by Bertrand on 08/03/2015.
//  Copyright (c) 2015 Bertrand Bloc'h. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {
    
    
    @IBOutlet weak var genderSwitch: UISwitch!
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    @IBAction func signUpButton(sender: AnyObject) {
        
        var user = PFUser.currentUser()

        if self.genderSwitch.on{
            
            user["interestedIn"] = "female"
        } else {
            user["interestedIn"] = "male"
        }
        self.performSegueWithIdentifier("testDrag", sender: self)
        }
    
    override func viewDidLoad() {
        var FBSession = PFFacebookUtils.session()
        var user = PFUser.currentUser()
        var accessToken = FBSession.accessTokenData.accessToken
        
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            let image = UIImage(data: data)
            
            self.profilePic.image = image
            
            user["image"] = data
            
            user.save()
            
            FBRequestConnection.startForMeWithCompletionHandler({
                connection, result, error in
                
                user["gender"] = result["gender"]
                user["name"] = result["name"]

                user.save()
                
                println(result)
                
                
            })
            
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
