//
//  CompoundDto.swift
//  ARChemistry
//
//  Created by HHumorous on 8/7/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct CompoundDto {
    var desc: String
    var name: String
    var symbol: String
    var image: String
    
    var dictionary:[String:Any] {
        return [
            "name": name,
            "desc" : desc,
            "symbol" : symbol,
            "image" : image
        ]
    }
    
}

extension CompoundDto : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let symbol = dictionary["symbol"] as? String,
            let image = dictionary["image"] as? String,
            let desc = dictionary["desc"] as? String else {return nil}
            
        self.init(desc: desc, name: name, symbol: symbol, image: image)
    }
}
