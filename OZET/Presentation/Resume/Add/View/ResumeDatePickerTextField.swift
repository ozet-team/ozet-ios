//
//  ResumeDatePickerTextField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

enum ResumeDatePickerTextFieldType {
  case certificateDate

  var title: String? {
    switch self {
    case .certificateDate:
      return "자격증 취득일"
    }
  }
}

final class ResumeDatePickerTextField: BaseView, AddResumeAddableComponent {
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
  init(type: ResumeDatePickerTextFieldType) {
    super.init(frame: .zero)
    self.configureSubViews()
    self.configureKeyboard()

    self.titleLabel.text = type.title
    self.textField.placeholder = "YYYY. MM. DD"
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

  // MARK: Configuration
  private func configureKeyboard() {
    let datePicker = UIDatePicker().then {
      $0.datePickerMode = .date
      $0.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
      if #available(iOS 13.4, *) {
        $0.preferredDatePickerStyle = .wheels
      }
    }
    self.textField.tintColor = .clear
    self.textField.inputView = datePicker
  }

  @objc private func handleDatePicker(_ datePicker: UIDatePicker) {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY. MM. dd"
    self.textField.text = formatter.string(from: datePicker.date)
  }
}
