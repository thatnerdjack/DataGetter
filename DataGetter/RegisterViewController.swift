//
//  RegisterViewController.swift
//  DataGetter
//
//  Created by block7 on 2/12/16.
//  Copyright © 2016 Jack Doherty. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var userFullName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    var login = Login()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hitReg(sender: AnyObject) {
        if(!login.registerUser(userEmail.text!, userPassword: userPassword.text!, userFullName: userFullName.text!)) {
            let alert = UIAlertController(title: "Login Error", message: "You're registration didn't work", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("regToMain", sender: nil)
        }
    }
}
