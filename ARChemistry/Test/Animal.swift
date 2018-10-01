//
//  Animal.swift
//  Test
//
//  Created by Admin on 9/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

struct List: Codable {
    var animals: [Animal]
}

struct Animal: Codable {
    let name: String
    let weight: Int
}
