//
//  ResumeListMultilineCell.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/26.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

final class ResumeListMultilineCell: BaseTableViewCell {
  
  // MARK: UI Components
  private let containerView = UIView().then {
    $0.layer.cornerRadius = 11
    $0.layer.masksToBounds = true
    $0.layer.borderColor = UIColor.ozet.gray3.cgColor
    $0.layer.borderWidth = 1
  }
  
  private let contentLabel = UILabel().then {
    $0.font = .ozet.body2
    $0.numberOfLines = 0
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
    
    self.containerView.addSubview(self.contentLabel)
    self.containerView.addSubview(self.arrowIconView)
  }
  
  func configure(content: String) {
    self.contentLabel.text = content
  }
  
  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()
    
    self.containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(10)
    }
    
    self.contentLabel.snp.makeConstraints { make in
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
  
  static func getHeight(content: String, width: CGFloat) -> CGFloat {
    let contentWidth = width - 50
    let contentHeight = content.height(forConstrainedWidth: contentWidth, font: .ozet.body2)
    let marginHeight = CGFloat(44)
    return contentHeight + marginHeight
  }
}

extension String {
  func height(
    forConstrainedWidth width: CGFloat,
    font: UIFont
  ) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(
      with: constraintRect,
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      attributes: [
        .font: font
      ],
      context: nil
    )
    return boundingBox.height
  }
}
