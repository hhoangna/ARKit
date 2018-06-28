//
//  LoginDto.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginDto: BaseDto {
    
    var userId:String?
    var password:String?


    convenience init(userName:String?,pass:String?) {
        self.init()
        self.userId = userName;
        self.password = pass;
    }

    
    required  convenience init?(map: Map) {
       self.init(map: map)
    }
    
    
    override func mapping(map: Map) {
        userId  <- map["userId"];
        password  <- map["password"];
    }
}

