//
//  ResumeListSectionHeaderView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

final class ResumeListSectionHeaderView: BaseHeaderFooterView {

  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.font = .ozet.header3
    $0.textColor = .ozet.gray4
  }

  // MARK: Init
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.configureSubViews()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.contentView.addSubview(self.titleLabel)
  }

  func configure(title: String?) {
    self.titleLabel.text = title
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(10)
    }
  }
}
