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

  private let dateField = DatePickerTextField()

  // MARK: Initializer
  init(type: ResumeDatePickerTextFieldType) {
    super.init(frame: .zero)
    self.configureSubViews()
    
    self.titleLabel.text = type.title
    self.backgroundColor = .ozet.whiteWithDark
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.dateField)
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

    self.dateField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
}
