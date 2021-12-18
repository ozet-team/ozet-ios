//
//  ResumeSelectionField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

enum ResumeSelectionFieldType {
  case careerWork

  var title: String? {
    switch self {
    case .careerWork:
      return "근무내용 & 성과"
    }
  }

  var placeholder: String? {
    switch self {
    case .careerWork:
      return "근무 내용 또는 성과를 입력해주세요"
    }
  }
}

final class ResumeSelectionField: BaseView, AddResumeAddableComponent {
  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.textColor = .ozet.gray3
    $0.font = .ozet.subtitle1
  }

  private let button = UIButton().then {
    $0.setTitleColor(.ozet.gray3, for: .normal)
    $0.contentEdgeInsets = UIEdgeInsets(top: 17, left: 15, bottom: 17, right: 15)
    $0.titleLabel?.font = .ozet.body1
    $0.contentHorizontalAlignment = .left
    $0.layer.borderColor = UIColor.ozet.black.withAlphaComponent(0.05).cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 8
  }

  // MARK: Properties
  private let type: ResumeSelectionFieldType

  // MARK: Initializer
  init(type: ResumeSelectionFieldType) {
    self.type = type
    super.init(frame: .zero)
    self.configureSubViews()

    self.titleLabel.text = type.title
    self.button.setTitle(type.placeholder, for: .normal)
    self.backgroundColor = .ozet.whiteWithDark
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.button)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview()
    }

    self.button.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview()
    }
  }
}
