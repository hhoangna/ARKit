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
        var password:String?
        var name:String?
        var birthday: String?
        var gender: Int?
        var address: String?
        var picture:Picture?
        var imageUrl: String?
        
        required convenience init?(map: Map) {
            self.init()
        }
        
        override func mapping(map: Map) {
            _id <- map["id"];
            email <- map["email"];
            name <- map["name"];
            picture <- map["picture"];
            gender <- map["gender"]
            birthday <- map["birthday"]
            address <- map["address"]
            imageUrl <- map["imageUrl"]
            password <- map["password"]
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
