//
//  BaseDto.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import ObjectMapper

//MARK: - Types
enum ParamsMethod : String {
    
    case GET = "GET";
    case POST = "POST";
    case PUT = "PUT";
    case PATCH = "PATCH";
    case DELETE = "DELETE";
    
    case DISK_SAVING = "DISK_SAVING";
}


class BaseDto:NSObject, Mappable {
    
    override init() {
        //
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    func getJSONString()-> [String: Any] {
        let json = self.toJSON()
        return json
    }
    
    func getJsonObject(method: ParamsMethod)-> Any {
        return self.getJSONString();
    }
}

