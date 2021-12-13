//
//  ResumeUpdateVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import AsyncDisplayKit

final class ResumeUpdateVC: BaseTextureVC {

  // MARK: Initializer
  init() {
    super.init(node: ResumeUpdateNode())
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
