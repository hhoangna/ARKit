//
//  User.swift
//  ARChemistry
//
//  Created by HHumorous on 7/23/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import Foundation
import FirebaseFirestore
import ObjectMapper

//MARK: UserDetail

class UserDetail: BaseDto {
    var name: String?
    var email: String?
    var birthday: Date?
    var gender: NSNumber?
    var address: String?
    var imageUrl: String?
    var pass: String?
    var id: String?
    var picture: Picture?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        email <- map["email"];
        name <- map["name"];
        imageUrl <- map["imageUrl"];
        address <- map["address"];
        birthday <- map["birthday"];
        gender <- map["gender"];
        id <- map["id"];
        picture <- map["picture"];
    }
    
}

class User: BaseDto {
    var token: String?
    var type: NSNumber?
    
    var user: UserDetail?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        token <- map["token"];
        type <- map["type"];
        user <- map["user"];
    }
}

class Picture: BaseDto {
    var data: Data?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        data <- map["data"]
    }
    
    class Data: BaseDto {
        var url: String?
        
        required convenience init?(map: Map) {
            self.init()
        }
        
        override func mapping(map: Map) {
            url <- map["url"];
        }
    }
}
