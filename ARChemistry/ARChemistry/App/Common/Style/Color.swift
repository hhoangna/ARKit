//
//  Color.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/8/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit

/// Common colors used throughout the app.
struct Color {
    static let white = UIColor.white
    static let clear = UIColor.clear
    static let blueHeader = UIColor(rgb: 0x009DF7)
    static let grayTitle = UIColor(rgb: 0xF6F6F6)
    static let fadedPurple = UIColor(rgb: 0x2b2f79, alpha: 0.73)
    static let lilac = UIColor(rgb: 0xe3e4f2)
    static let blue = UIColor(rgb: 0x4350ae)
    static let mediumGray = UIColor(rgb: 0x9b9b9b)
    static let rosyPink = UIColor(rgb: 0xef5f70)
    static let warmGrey2 = UIColor(rgb: 0x7a7a7a7)
    static let shadow = UIColor(rgb: 0x000000, alpha: 0.5)
    static let lightGray = UIColor(rgb: 0xcacaca)
    static let teal = UIColor(rgb: 0x76c1d6)
    static let black = UIColor.black
    static let pinkishGreyTwo = UIColor(rgb: 0xbebebe)
    static let deepBlue73 = UIColor(rgb: 0x00007f)
    static let darkGray = UIColor(rgb: 0x898989)
    static let red = UIColor(rgb: 0xe7465d)
    static let mediumPink = UIColor(rgb: 0xee5f70)
    static let fadedMediumPink = mediumPink.withAlphaComponent(0.85)
    static let offWhite = UIColor(rgb: 0xf4f4f4)
    static let transparentWhite = white.withAlphaComponent(0.90)
    static let paleGray = UIColor(rgb: 0xe3e4f3)
    
    static let primaryLabelTextColor = warmGrey2
    static let textFieldPlaceholderColor = pinkishGreyTwo
    static let textFieldTextColor = Color.blueHeader
    static let navigationBackgroundColor = white
    static let highlightedColor = Color.teal
}
