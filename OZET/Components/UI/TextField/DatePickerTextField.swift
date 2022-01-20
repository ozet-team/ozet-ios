//
//  DatePickerTextField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/20.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

final class DatePickerTextField: BaseView {
  private let textFieldContainer = UIView().then {
    $0.layer.borderColor = UIColor.ozet.black.withAlphaComponent(0.05).cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 8
  }

  private let textField = UITextField().then {
    $0.font = .ozet.body1
    $0.textColor = .ozet.blackWithDark
    $0.tintColor = .ozet.purple
    $0.placeholder = "YYYY. MM. DD"
  }

  // MARK: Initializer
  init() {
    super.init(frame: .zero)
    self.configureSubViews()
    self.configureKeyboard()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.textFieldContainer)
    self.textFieldContainer.addSubview(self.textField)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.textFieldContainer.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview()
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

