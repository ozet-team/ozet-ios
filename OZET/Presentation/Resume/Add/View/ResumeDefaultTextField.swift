//
//  ResumeDefaultTextField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

enum ResumeDefaultTextFieldType {
  case shopName

  var title: String? {
    switch self {
    case .shopName:
      return "샵 이름"
    }
  }

  var placeholder: String? {
    switch self {
    case .shopName:
      return "샵 이름을 입력해주세요"
    }
  }

  var keyboardType: UIKeyboardType {
    switch self {
    case .shopName:
      return .default
    }
  }
}

final class ResumeDefaultTextField: BaseView, AddResumeAddableComponent {
  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.textColor = .ozet.gray3
    $0.font = .ozet.subtitle1
  }

  private let textFieldContainer = UIView().then {
    $0.layer.borderColor = UIColor.ozet.black.withAlphaComponent(0.05).cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 8
  }

  private let textField = UITextField().then {
    $0.font = .ozet.body1
    $0.textColor = .ozet.blackWithDark
    $0.tintColor = .ozet.purple
  }

  // MARK: Initializer
  init(type: ResumeDefaultTextFieldType) {
    super.init(frame: .zero)
    self.configureSubViews()

    self.titleLabel.text = type.title
    self.textField.placeholder = type.placeholder
    self.textField.keyboardType = type.keyboardType
    self.backgroundColor = .ozet.whiteWithDark
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.textFieldContainer)
    self.textFieldContainer.addSubview(self.textField)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.snp.makeConstraints { make in
      make.height.equalTo(74)
    }

    self.titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview()
    }

    self.textFieldContainer.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview()
      make.height.equalTo(52)
    }

    self.textField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(15)
      make.top.bottom.equalToSuperview().inset(17)
    }
  }
}
