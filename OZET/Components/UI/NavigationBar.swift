//
//  NavigationBar.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import TouchAreaInsets

extension Reactive where Base: NavigationBar {
  var tapBack: ControlEvent<Void> {
    base.backButton.rx.tap
  }
}

class NavigationBar: BaseView {

  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.font = .ozet.header4
    $0.textColor = .ozet.blackWithDark
  }

  fileprivate let backButton = UIButton().then {
    $0.setImage(R.image.iconBack(), for: .normal)
    $0.contentMode = .scaleToFill
    $0.touchAreaInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }

  // MARK: Init
  init(title: String?) {
    super.init(frame: .zero)
    self.titleLabel.text = title
    self.configureSubView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubView() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.backButton)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.snp.makeConstraints { make in
      make.height.equalTo(44)
    }

    self.titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }

    self.backButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.centerY.equalToSuperview()
    }
  }
}
