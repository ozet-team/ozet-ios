//
//  ResumeListHeaderContentView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

final class ResumeListHeaderContentView: BaseView {
  // MARK: UI Components
  private let stackView = UIStackView().then {
    $0.axis = .horizontal
  }

  private let titleLabel = UILabel().then {
    $0.font = .ozet.body1
    $0.textColor = .ozet.gray3
  }

  private let contentLabel = UILabel().then {
    $0.font = .ozet.body1
    $0.textColor = .ozet.blackWithDark
  }
  
  var content: String? {
    get { self.contentLabel.text }
    set { self.contentLabel.text = newValue }
  }

  // MARK: Init
  init(title: String?, content: String?) {
    super.init(frame: .zero)

    self.titleLabel.text = title
    self.contentLabel.text = content
    self.configureSubViews()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.stackView)
    self.stackView.addArrangedSubview(self.titleLabel)
    self.stackView.addArrangedSubview(self.contentLabel)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.height.equalTo(18)
    }

    self.titleLabel.snp.makeConstraints { make in
      make.width.equalTo(100)
    }
  }
}
