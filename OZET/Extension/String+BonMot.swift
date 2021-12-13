//
//  String+Extension.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

import BonMot

extension String {
  func styled(font: UIFont, color: UIColor) -> NSAttributedString {
    return self.styled(
      with: StringStyle(
        .font(font),
        .color(color)
      )
    )
  }
}
