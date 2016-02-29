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
                let registeredUser = self.backendless.userService.login(userEmail, password: userPassword)
                print("User has been logged in (SYNC): \(registeredUser)")
                didLogin = true
            },
            catchblock: { (exception) -> Void in
                print("Server reported an error: \(exception as! Fault)")
        })
        return didLogin
    }
    
    func registerUser(userEmail: String, userPassword: String, userFullName: String) -> Bool {
        var didRegister = false
        Types.tryblock(
            { () -> Void in
                let user = BackendlessUser()
                user.email = userEmail
                user.password = userPassword
                user.setProperty("name", object: userFullName)
                
                let registeredUser = self.backendless.userService.registering(user)
                print("Uuser has been registerd (SYNC): \(registeredUser)")
                
                self.loginUser(registeredUser.email, userPassword: registeredUser.password)
                didRegister = true
            },
            catchblock: { (exception) -> Void in
                print("Server reported an error: \(exception as! Fault)")
        })
        return didRegister
    }
}
