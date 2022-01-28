//
//  BaseTableViewCell.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import RxSwift

class BaseTableViewCell: UITableViewCell {

  // MARK: Properties
  private(set) var didMakeConstraints = false
  var disposeBag = DisposeBag()

  // MARK: Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialize()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  private func initialize() {
    self.setNeedsUpdateConstraints()
  }

  // MARK: Layout
  override func updateConstraints() {
    if !self.didMakeConstraints {
      self.makeConstraints()
      self.didMakeConstraints = true
    }
    super.updateConstraints()
  }

  func makeConstraints() {
    // Override point
  }
}
