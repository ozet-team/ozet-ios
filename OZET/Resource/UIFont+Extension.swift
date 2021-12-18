//
//  UIFont+Extension.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

extension UIFont {
  static let ozet = Ozet()

  struct Ozet {
    let header2 = UIFont.systemFont(ofSize: 18, weight: .semibold)
    let header3 = UIFont.systemFont(ofSize: 16, weight: .bold)
    let header4 = UIFont.systemFont(ofSize: 16, weight: .medium)
    let header5 = UIFont.systemFont(ofSize: 15, weight: .semibold)
    let header6 = UIFont.systemFont(ofSize: 14, weight: .semibold)
    let subtitle1 = UIFont.systemFont(ofSize: 12, weight: .medium)
    let subtitle2 = UIFont.systemFont(ofSize: 10, weight: .regular)
    let button = UIFont.systemFont(ofSize: 17, weight: .bold)
    let body1 = UIFont.systemFont(ofSize: 15, weight: .medium)
    let body2 = UIFont.systemFont(ofSize: 15, weight: .regular)
    let body3 = UIFont.systemFont(ofSize: 14, weight: .medium)
  }
}
