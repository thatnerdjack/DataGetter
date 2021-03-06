//
//  ViewController.swift
//  DataGetter
//
//  Created by block7 on 2/9/16.
//  Copyright © 2016 Jack Doherty. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var login = Login()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "loginToReg") {
//            let DVC = segue.destinationViewController as! RegisterViewController
//            DVC.userEmail.text = emailField.text!
//            DVC.userPassword.text = passwordField.text!
//        }
//    }
    
    @IBAction func hitLogin(sender: AnyObject) {
        if (!login.loginUser(emailField.text!, userPassword: passwordField.text!)) {
            let alert = UIAlertController(title: "Login Error", message: "You're login didn't work", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("loginToMain", sender: nil)
        }
    }
    
    @IBAction func hitFORCEMAIN(sender: AnyObject) {
        login.loginUser("test@test.com", userPassword: "test")
        performSegueWithIdentifier("loginToMain", sender: nil)
    }
}