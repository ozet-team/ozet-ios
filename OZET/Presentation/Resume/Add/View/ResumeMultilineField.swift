//
//  ResumeMultilineField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

enum ResumeMultilineFieldType {
  case careerProject
  case introduction

  var title: String? {
    switch self {
    case .careerProject:
      return R.string.ozet.resumeUpdateCareerProjectTitle()
    case .introduction:
      return R.string.ozet.resumeUpdateIntroductionTitle()
    }
  }

  var placeholder: String? {
    switch self {
    case .careerProject:
      return R.string.ozet.resumeUpdateCareerProjectPlaceHolder()
    case .introduction:
      return R.string.ozet.resumeUpdateIntroductionPlaceHolder()
    }
  }
}

final class ResumeMultilineField: BaseView, AddResumeAddableComponent {
  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.textColor = .ozet.gray3
    $0.font = .ozet.subtitle1
  }

  private let textView = UITextView().then {
    $0.font = .ozet.body1
    $0.textColor = .ozet.gray3
    $0.textContainer.lineFragmentPadding = 0
    $0.textContainerInset = .zero
    $0.tintColor = .ozet.purple
  }

  // MARK: Properties
  private let type: ResumeMultilineFieldType

  // MARK: Initializer
  init(type: ResumeMultilineFieldType) {
    self.type = type
    super.init(frame: .zero)
    self.configureSubViews()

    self.titleLabel.text = type.title
    self.textView.text = type.placeholder
    self.textView.delegate = self
    self.backgroundColor = .ozet.whiteWithDark
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.textView)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview()
    }

    self.textView.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview()
      make.height.equalTo(100)
    }
  }
}

extension ResumeMultilineField: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
      textView.text = nil
      textView.textColor = .ozet.blackWithDark
   }

   func textViewDidEndEditing(_ textView: UITextView) {
     if textView.text.isEmpty {
       textView.text = self.type.placeholder
       textView.textColor = .ozet.gray3
     }
   }
}
