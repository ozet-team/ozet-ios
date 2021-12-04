//
//  BaseScrollView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit
import Then
import SnapKit
import RxSwift

class BaseScrollView: UIScrollView {
  // MARK: Properties
  private(set) var didMakeConstraints = false
  let disposeBag = DisposeBag()

  // MARK: Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
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
