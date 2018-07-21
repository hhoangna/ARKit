//
//  Configuration.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import ObjectMapper
import FirebaseAuth

class Configuration: NSObject {
    
   fileprivate var userDefaults:UserDefaults?
    var user:UserDto?{
        get {
            return getUser()
        }
    }
    var hasLogin:Bool?{
        get {
            let token = App().config?.user?.token;
            return !isEmpty(token);
        }
    }
    
    override init() {
        userDefaults = UserDefaults.standard
    }
    
    
    
    func setUser(_ userDto:UserDto?) {
        if(userDto != nil) {
            let data = userDto?.getJSONString()
            if (data != nil) {
                userDefaults?.set(data, forKey: CF_UserData)

            } else {
                //
            }
            
        } else {
            userDefaults?.removeObject(forKey: CF_UserData)
        }
        
        userDefaults?.synchronize()
    }
    
  private  func getUser() -> UserDto? {
        
        var user:UserDto?
        if(user !=  nil) {
            user = self.user
        }else {
            let data = userDefaults?.object(forKey: CF_UserData)
            if(data != nil) {
                user =  UserDto(JSON: data as! [String:Any])
            }
        }
        
        return user;
    }
}
