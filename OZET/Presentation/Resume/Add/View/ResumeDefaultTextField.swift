//
//  ResumeDefaultTextField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

enum ResumeDefaultTextFieldType {
  case careerShopName
  case careerPosition
  case certificationName
  case certificationAgency
  case schoolName
  case schoolSubjectName
  case schoolLocation
  case militaryServiceReason
  case address

  var title: String? {
    switch self {
    case .careerShopName:
      return R.string.ozet.resumeUpdateCareerShopNameTitle()
    case .careerPosition:
      return R.string.ozet.resumeUpdateCareerPositionTitle()
    case .certificationName:
      return R.string.ozet.resumeUpdateCertificationNameTitle()
    case .certificationAgency:
      return R.string.ozet.resumeUpdateCertificationAgencyTitle()
    case .schoolName:
      return R.string.ozet.resumeUpdateSchoolNameTitle()
    case .schoolSubjectName:
      return R.string.ozet.resumeUpdateSchoolSubjectNameTitle()
    case .schoolLocation:
      return R.string.ozet.resumeUpdateSchoolLocationTitle()
    case .militaryServiceReason:
      return R.string.ozet.resumeUpdateMilitaryExemptionReasonTitle()
    case .address:
      return R.string.ozet.resumeUpdateAddressTitle()
    }
  }

  var placeholder: String? {
    switch self {
    case .careerShopName:
      return R.string.ozet.resumeUpdateCareerShopNamePlaceHolder()
    case .careerPosition:
      return R.string.ozet.resumeUpdateCareerPositionPlaceHolder()
    case .certificationName:
      return R.string.ozet.resumeUpdateCertificationNamePlaceHolder()
    case .certificationAgency:
      return R.string.ozet.resumeUpdateCertificationAgencyPlaceHolder()
    case .schoolName:
      return R.string.ozet.resumeUpdateSchoolNamePlaceHolder()
    case .schoolSubjectName:
      return R.string.ozet.resumeUpdateSchoolSubjectNamePlaceHolder()
    case .schoolLocation:
      return R.string.ozet.resumeUpdateSchoolLocationPlaceHolder()
    case .militaryServiceReason:
      return R.string.ozet.resumeUpdateMilitaryExemptionReasonPlaceHolder()
    case .address:
      return R.string.ozet.resumeUpdateAddressPlaceHolder()
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
