//
//  MainViewController.swift
//  DataGetter
//
//  Created by block7 on 2/12/16.
//  Copyright © 2016 Jack Doherty. All rights reserved.
//

import UIKit

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
//        let dataStore = self.backendless.data.of(DataObject.ofClass())
//        
//        dataStore.find({ (result: BackendlessCollection!) -> Void in
//            var getSuccess = false
//            var index = 0
//            while !getSuccess {
//                var datas = result.getCurrentPage()
//                for d in datas {
//                    if d.nickname == self.nicknameGetField.text! {
//                        self.nicknameGetLabel.text = d.nickname
//                        self.numGetLabel.text = "\(d.num)"
//                        self.nicknameGetField.text = ""
//                        getSuccess = true
//                    } else {
//                        print("Object not found \(index))")
//                    }
//                    index++
//                }
//                datas = result.nextPage().getCurrentPage()
//            }
//            }, error: { (fault: Fault!) -> Void in
//                print("Server reported an error: \(fault)")
//        })
        
        
    }
    

}
