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
    
    var setNick: String?
    var setNum: Int?
    
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
        if let doesHaveNick = nicknameSetField.text {
            setNick = doesHaveNick
        }
        if let doesHaveNum = numSetField.text {
            setNum = Int(doesHaveNum)
        }
        
//        Types.tryblock(
//            { () -> Void in
//                var dataObjects = self.backendless.persistenceService.of(DataObject.ofClass())
//            },
//            catchblock: { (exception) -> Void in
//            })
        //IS THIS REALLY THE BEST WAY TO DO THIS??? CHECK THE API DOCS!
    }

    @IBAction func getNum(sender: AnyObject) {
    }
    

}
