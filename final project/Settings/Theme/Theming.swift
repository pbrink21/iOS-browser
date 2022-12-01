//
//  Theming.swift
//  final project
//
//  Created by Paul Brinkmann on 8/24/22.
//

import Foundation
import UIKit
import RealmSwift

//string to color translation layer
let blueKey = "blue"
let brownKey = "brown"
let cyanKey = "cyan"
let grayKey = "gray"
let greenKey = "green"
let indigoKey = "indigo"
let mintKey = "mint"
let orangeKey = "orange"
let pinkKey = "pink"
let purpleKey = "purple"
let redKey = "red"
let tealKey = "teal"
let yellowKey = "yellow"
let blackKey = "black"
let darkGrayKey = "darkGray"
let lightGrayKey = "lightGray"
let whiteKey = "white"
let colorOptions = [blueKey, brownKey, cyanKey, grayKey, greenKey, indigoKey, mintKey, orangeKey, pinkKey, purpleKey, redKey, tealKey, yellowKey, blackKey, darkGrayKey, lightGrayKey, whiteKey]
let keyToColor = [
    blueKey: UIColor.systemBlue,
    brownKey: UIColor.systemBrown,
    cyanKey: UIColor.systemCyan,
    grayKey: UIColor.systemGray,
    greenKey: UIColor.systemGreen,
    indigoKey: UIColor.systemIndigo,
    mintKey: UIColor.systemMint,
    orangeKey: UIColor.systemOrange,
    pinkKey: UIColor.systemPink,
    purpleKey: UIColor.systemPurple,
    redKey: UIColor.systemRed,
    tealKey: UIColor.systemTeal,
    yellowKey: UIColor.systemYellow,
    blackKey: UIColor.black,
    darkGrayKey: UIColor.darkGray,
    lightGrayKey: UIColor.lightGray,
    whiteKey: UIColor.white,
]

//Theme stuff
let lightKey = "light"
let darkKey = "dark"
let pitchBlackKey = "black"
let themeOptions = [lightKey, darkKey, pitchBlackKey]
let color1 = [
	lightKey: whiteKey,
	darkKey: darkGrayKey,
	pitchBlackKey: blackKey,
]
let color2 = [
	lightKey: lightGrayKey,
	darkKey: grayKey,
	pitchBlackKey: blackKey,
]
let color3 = [
	lightKey: darkGrayKey,
	darkKey: lightGrayKey,
	pitchBlackKey: grayKey,
]
let textColor = [
	lightKey: blackKey,
	darkKey: whiteKey,
	pitchBlackKey: whiteKey,
]

func getColor1() -> UIColor {
    let theme = getSetting(key: themeKey)
    return keyToColor[color1[theme.value]!]!
}
func getColor2() -> UIColor {
    let theme = getSetting(key: themeKey)
    return keyToColor[color2[theme.value]!]!
}
func getColor3() -> UIColor {
	let theme = getSetting(key: themeKey)
	return keyToColor[color3[theme.value]!]!
}
func getTextColor() -> UIColor {
	let theme = getSetting(key: themeKey)
	return keyToColor[textColor[theme.value]!]!
}
func getAccentColor() -> UIColor {
    let color = getSetting(key: accentColorKey)
    return keyToColor[color.value]!
}
