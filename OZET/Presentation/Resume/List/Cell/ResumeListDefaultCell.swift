//
//  ResumeListDefaultCell.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

final class ResumeListDefaultCell: BaseTableViewCell {

  // MARK: UI Components
  private let containerView = UIView().then {
    $0.layer.cornerRadius = 11
    $0.layer.masksToBounds = true
    $0.layer.borderColor = UIColor.ozet.gray3.cgColor
    $0.layer.borderWidth = 1
  }

  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 4
  }

  private let titleLabel = UILabel().then {
    $0.font = .ozet.body1
    $0.textColor = .ozet.blackWithDark
  }

  private let dateLabel = UILabel().then {
    $0.font = .ozet.subtitle2
    $0.textColor = .ozet.gray3
  }

  private let arrowIconView = UIImageView().then {
    $0.image = R.image.iconArrowRight()
  }

  // MARK: Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.selectionStyle = .none
    self.backgroundColor = .clear
    self.configureSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: Configuartion
  private func configureSubviews() {
    self.contentView.addSubview(self.containerView)
    self.containerView.addSubview(self.stackView)
    self.containerView.addSubview(self.arrowIconView)

    self.stackView.addArrangedSubview(self.titleLabel)
    self.stackView.addArrangedSubview(self.dateLabel)
  }

  func configure(item: ResumeDefaultItem) {
    self.titleLabel.text = item.title
    self.dateLabel.isHidden = item.date == nil
    self.dateLabel.text = item.date
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(10)
    }

    self.stackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(15)
      make.top.bottom.equalToSuperview().inset(12)
      make.trailing.equalToSuperview().inset(35)
    }

    self.arrowIconView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(20)
      make.height.equalTo(12)
      make.width.equalTo(6)
      make.centerY.equalToSuperview()
    }
  }
}
