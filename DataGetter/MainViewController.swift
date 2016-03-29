//
//  MainViewController.swift
//  DataGetter
//
//  Created by block7 on 2/12/16.
//  Copyright © 2016 Jack Doherty. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameSetField: UITextField!
    @IBOutlet weak var numSetField: UITextField!
    @IBOutlet weak var nicknameGetField: UITextField!
    @IBOutlet weak var nicknameGetLabel: UILabel!
    @IBOutlet weak var numGetLabel: UILabel!
    
    let backendless = Backendless.sharedInstance()
    
    var user: BackendlessUser = Backendless.sharedInstance().userService.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = (user.getProperty("name") as! String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setNum(sender: AnyObject) {
        let object = DataObject()
        if let doesHaveNick = nicknameSetField.text {
            object.nickname = doesHaveNick
        }
        if let doesHaveNum = numSetField.text {
            object.num = Int(doesHaveNum)!
        }
        
        let dataStore = self.backendless.data.of(DataObject.ofClass())
        
        dataStore.save(object,
            response: { (result: AnyObject!) -> Void in
                let obj = result as! DataObject
                print("Data has been succesfully saved: \(obj.objectId)")
                
                Types.tryblock({ () -> Void in
                    let dataObjects = self.user.getProperty("dataObjects") as! NSMutableArray
                    dataObjects.addObject(obj)
                    self.user.setProperty("dataObjects", object: dataObjects)
                    self.user = self.backendless.userService.update(self.user)
                    }, catchblock: { (exception) -> Void in
                        print("Server reported an error: \(exception as! Fault)")
                })
                
                self.nicknameSetField.text = ""
                self.numSetField.text = ""
                
            },
            error: { (fault: Fault!) -> Void in
                print("Server reported an error: \(fault)")
                
                let alert = UIAlertController(title: "Set Error", message: "Data failed to set.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        })
    }

    @IBAction func getNum(sender: AnyObject) {
        let dataStore = self.backendless.data.of(BackendlessUser.ofClass())
        var dataObjects : NSMutableArray = []
        var getSuccess = false
        
        dataStore.findID(user.objectId, response: { (result: AnyObject!) -> Void in
            let foundUser = result as! BackendlessUser
            print("Found user \(foundUser.email)")
            dataObjects = foundUser.getProperty("dataObjects") as! NSMutableArray
            for data in dataObjects {
                if data.nickname == self.nicknameGetField.text! {
                    self.nicknameGetLabel.text = data.nickname
                    self.numGetLabel.text = "\(data.num)"
                    self.nicknameGetField.text = ""
                    getSuccess = true
                }
            }
            if !getSuccess {
                let alert = UIAlertController(title: "Get Error", message: "Data failed to get. You may not have permission or it may not exist. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            },
            error: { (fault: Fault!) -> Void in
                print("Server reported an error (find user): \(fault)")
        })
    }
    
}
