//
//  RegisterDto.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/15/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterDto: BaseDto {
    
    var email:String?
    var password:String?
    var userId:String?
    
    init(_ email:String?,_ pass:String?,_ userId:String?) {
        super.init()
        self.email = email;
        self.password = pass;
        self.userId = userId;
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    override func mapping(map: Map) {
         email <- map["email"]
         password <- map["password"]
         userId <- map["userId"];
    }
}
