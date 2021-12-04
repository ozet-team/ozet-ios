//
//  UIColor+Rswift.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/02.
//

import UIKit

extension UIColor {
  static let ozet = OZET()

  struct OZET {
    let purple = R.color.purple()!
    let white = R.color.white()!
    let whiteWithDark = R.color.whiteWithDark()!
    let black = R.color.black()!
    let blackWithDark = R.color.blackWithDark()!
    let gray1 = R.color.gray1()!
    let gray2 = R.color.gray2()!
    let gray3 = R.color.gray3()!
  }
}
