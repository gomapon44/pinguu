//
//  Global.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/07/15.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit

enum InputMode: Int {
    case HEX = 1
    case RGB = 2
}
var inputMode: InputMode = .HEX

enum OutputMode: Int {
    case PNG = 1
    case JPEG = 2
}
var outputMode: OutputMode = .PNG

enum ImageSize: Int {
    case S = 1
    case M = 2
    case L = 3
}
var imageSize: ImageSize = .M

var codeLabel: Bool = true

var editing: Bool = false
var deviceIsSE: Bool = false
let myGlay: UIColor = UIColor(rgbcode: "225,225,225")
let myRed: UIColor = UIColor(rgbcode: "159,030,035")

let testDevicesID: [Any]? = ["kGADSimulatorID", "219bb2de4ccadd59774cb95f6a8ea973", "1947ad613098260b66052c4c26d2306d"] // simulator,iPad,iPhone

var deviceWidth: CGFloat = UIScreen.main.bounds.width
var appWidth: CGFloat = deviceWidth
var isMultiTasking: Bool = false
