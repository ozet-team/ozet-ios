//
//  BaseTextureVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa
import RxViewController
import Then

class BaseTextureVC: ASDKViewController<ASDisplayNode> {
  // MARK: Properties
  var disposeBag = DisposeBag()

  // MARK: Initializer
  override init(node: ASDisplayNode) {
    super.init(node: node)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .ozet.whiteWithDark
    self.view.setNeedsUpdateConstraints()
  }
}
