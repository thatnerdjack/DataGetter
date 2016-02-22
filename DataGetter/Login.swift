//
//  Login.swift
//  DataGetter
//
//  Created by block7 on 2/12/16.
//  Copyright © 2016 Jack Doherty. All rights reserved.
//

import UIKit

class Login: NSObject {
    var backendless = Backendless.sharedInstance()
    
    func loginUser(userEmail: String, userPassword: String) -> Bool {
        var didLogin = false
        Types.tryblock(
            { () -> Void in
                var registeredUser = self.backendless.userService.login(userEmail, password: userPassword)
                print("User has been logged in (SYNC): \(registeredUser)")
                didLogin = true
            },
            catchblock: { (exception) -> Void in
                print("Server reported an error: \(exception as! Fault)")
        })
        return didLogin
    }
    
//    func registerUser(userEmail: String, userPassword: String, userFullName: String) {
//        
//    }
}
