//
//  ResumeDateRangeField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/20.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

extension UISwitch {
  func set(width: CGFloat, height: CGFloat) {
    let standardHeight: CGFloat = 31
    let standardWidth: CGFloat = 51
    let heightRatio = height / standardHeight
    let widthRatio = width / standardWidth
    transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
  }
}

enum ResumeDateRangeFieldType {
  case careerDuration
  case schoolDuration

  var title: String? {
    switch self {
    case .careerDuration:
      return "근무 기간"
    case .schoolDuration:
      return "재학 기간"
    }
  }
}

final class ResumeDateRangeField: BaseView, AddResumeAddableComponent {

  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.textColor = .ozet.gray3
    $0.font = .ozet.subtitle1
  }

  private let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillProportionally
  }

  private let startField = DatePickerTextField()

  private let rangeLabel = UILabel().then {
    $0.text = "~"
    $0.font = .ozet.header6
    $0.textAlignment = .center
  }

  private let endField = DatePickerTextField()

  // MARK: Initializer
  init(type: ResumeDateRangeFieldType) {
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
    self.addSubview(self.stackView)

    self.stackView.addArrangedSubview(self.startField)
    self.stackView.addArrangedSubview(self.rangeLabel)
    self.stackView.addArrangedSubview(self.endField)
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

    self.stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }

    self.rangeLabel.snp.makeConstraints { make in
      make.width.equalTo(10)
    }
  }
}
