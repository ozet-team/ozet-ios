//
//  BaseTableViewHeaderFooterView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/15.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import RxSwift

class BaseHeaderFooterView: UITableViewHeaderFooterView {
  // MARK: Properties
  private(set) var didMakeConstraints = false
  var disposeBag = DisposeBag()

  // MARK: Initializer
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Layout
  func makeConstraints() {
    // override point.
  }

  override func updateConstraints() {
    if !self.didMakeConstraints {
      self.makeConstraints()
      self.didMakeConstraints = true
    }

    super.updateConstraints()
  }
}
