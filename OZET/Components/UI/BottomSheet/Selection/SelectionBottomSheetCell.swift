//
//  SelectionBottomSheetCell.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

final class SelectionBottomSheetCell: BaseTableViewCell {

  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.font = .ozet.body2
    $0.textColor = .ozet.blackWithDark
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

  // MARK: Configuration
  private func configureSubviews() {
    self.contentView.addSubview(self.titleLabel)
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.titleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(12)
    }
  }

  // MARK: Bind
  func bind(title: String) {
    self.titleLabel.text = title
  }

  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    self.updateSelection(isSelected: highlighted)
  }

  private func updateSelection(isSelected: Bool) {
    if isSelected {
      self.contentView.backgroundColor = .ozet.blackWithDark.withAlphaComponent(0.2)
    } else {
      self.contentView.backgroundColor = .ozet.whiteWithDark
    }
  }
}
