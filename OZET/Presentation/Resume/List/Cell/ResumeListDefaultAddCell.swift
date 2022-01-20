//
//  ResumeListDefaultAddCell.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/15.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

final class ResumeListDefaultAddCell: BaseTableViewCell {

  // MARK: UI Components
  private let button = UIButton().then {
    $0.layer.cornerRadius = 11
    $0.layer.masksToBounds = true
    $0.backgroundColor = .ozet.gray1.withAlphaComponent(0.5)
    $0.setTitle("+ 추가하기", for: .normal)
    $0.setTitleColor(.ozet.purple, for: .normal)
    $0.titleLabel?.font = .ozet.header6
  }

  // MARK: Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.selectionStyle = .none
    self.configureSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: Configuartion
  private func configureSubviews() {
    self.contentView.addSubview(self.button)
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.button.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(10)
    }
  }
}
