//
//  ElementDto.swift
//  ARChemistry
//
//  Created by HHumorous on 7/24/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol DocumentSerializable  {
    init?(dictionary:[String:Any])
}


struct ElementDto {
    var atom: NSNumber
    var desc: String
    var mass: String
    var name: String
    var type: String
    var status: String
    var symbol: String
    var image: String
    
    var dictionary:[String:Any] {
        return [
            "name": name,
            "atom" : atom,
            "desc" : desc,
            "type": type,
            "status" : status,
            "symbol" : symbol,
            "image" : image,
            "mass": mass
        ]
    }
    
}

extension ElementDto : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let symbol = dictionary["symbol"] as? String,
            let desc = dictionary["desc"] as? String,
            let atom = dictionary["atom"] as? NSNumber,
            let type = dictionary["type"] as? String,
            let status = dictionary["status"] as? String,
            let image = dictionary["image"] as? String,
            let mass = dictionary["mass"] as? String else {return nil}
        
        self.init(atom: atom, desc: desc, mass: mass, name: name, type: type, status: status, symbol: symbol, image: image)
    }
}
