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
    @IBOutlet weak var nicknameGetField: UILabel!
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
            },
            error: { (fault: Fault!) -> Void in
                print("Server reported an error: \(fault)")
        })
    }

    @IBAction func getNum(sender: AnyObject) {
    }
    

}
