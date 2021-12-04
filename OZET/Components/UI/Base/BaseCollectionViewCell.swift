//
//  BaseCollectionViewCell.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit
import Then
import SnapKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
  // MARK: Properties
  private(set) var didMakeConstraints = false
  var disposeBag = DisposeBag()

  // MARK: Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
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
