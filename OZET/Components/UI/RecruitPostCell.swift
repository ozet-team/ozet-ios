//
//  RecruitPostCell.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit
import RxKeyboard
import RxSwift
import RxCocoa

final class RecruitPostCell: BaseCollectionViewCell {
  // MARK: UI Components
  private let thumbnailImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.image = R.image.testImage()
    $0.layer.cornerRadius = 4
    $0.clipsToBounds = true
  }

  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 4
  }

  private let titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14)
    $0.textColor = .ozet.blackWithDark
    $0.numberOfLines = 2
  }

  private let shopLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = .ozet.gray3
  }

  private let localLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = .ozet.gray3
  }

  // MARK: Init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.configureSubViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("")
  }
  
  // MARK: Configure
  func configure(item: Announcement) {
    self.titleLabel.text = item.title
    self.shopLabel.text = item.shopName
    let locationComponents = item.shopLocation.components(separatedBy: " ")
    self.localLabel.text = locationComponents[0...1].joined(separator: " ")
  }

  // MARK: Layout
  private func configureSubViews() {
    self.contentView.addSubview(self.thumbnailImageView)
    self.contentView.addSubview(self.contentStackView)

    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.shopLabel)
    self.contentStackView.addArrangedSubview(self.localLabel)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.thumbnailImageView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalTo(self.thumbnailImageView.snp.width).multipliedBy(0.6)
    }

    self.contentStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(self.thumbnailImageView.snp.bottom).offset(12)
    }
  }
}
