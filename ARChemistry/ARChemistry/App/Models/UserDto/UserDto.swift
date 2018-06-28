//
//  UserDto.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import ObjectMapper


class UserDto: BaseDto {
    
    class User:BaseDto {
        var _id:String?
        var email:String?
        var userId:String?
        var createData:Date?
        
        required convenience init?(map: Map) {
            self.init()
        }
        
        override func mapping(map: Map) {
            _id <- map["_id"];
            email <- map["email"];
            userId <- map["userId"];
            createData <- (map["createData"] ,DateTransform());
        }
    }
    
    var user:User?
    var token:String?

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        token <- map["token"]
        user <- map["user"]
    }
}
