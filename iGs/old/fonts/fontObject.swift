//
//  fontObject.swift
//  iGs
//
//  Created by Hattapong on 12/1/2564 BE.
//

import UIKit


var MAIN_FONT_NAME = "DBHelvethaicaX-Med"
var MAIN_FONT_COLOR = #colorLiteral(red: 0.7490196078, green: 0.1294117647, blue: 0.1882352941, alpha: 1)
var FONT_SHIFT:CGFloat = 0


var fH1:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 60 + FONT_SHIFT)
var fH2:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 48 + FONT_SHIFT)
var fH3:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 32 + FONT_SHIFT)
var fH4:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 24 + FONT_SHIFT)
var fH5:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 16 + FONT_SHIFT)
var fH6:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 14 + FONT_SHIFT)


var fNormal:UIFont? = UIFont(name: MAIN_FONT_NAME, size: 18 + FONT_SHIFT)

func fNormalWith(size: CGFloat = 18.0) -> UIFont? {
    return UIFont(name: MAIN_FONT_NAME, size: size)
}
