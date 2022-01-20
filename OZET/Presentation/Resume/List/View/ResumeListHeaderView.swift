//
//  ResumeListHeaderView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

final class ResumeListHeaderView: BaseView {

  // MARK: Constants
  private enum Metric {
    static let profileViewSize = CGFloat(130)
  }

  // MARK: UI Components
  private let profileImageView = UIImageView().then {
    $0.layer.cornerRadius = Metric.profileViewSize/2
    $0.layer.masksToBounds = true
    $0.image = R.image.defaultProfileImage()
  }

  private let updateLabel = UILabel().then {
    $0.font = .ozet.subtitle1
    $0.textColor = .ozet.gray3
    $0.text = "마지막 수정일 2022.01.15"
  }

  private let titleLabel = UILabel().then {
    $0.font = .ozet.header2
    $0.textColor = .ozet.gray4
    $0.text = "기본정보"
  }

  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 12
  }

  private let bottomLineView = UIView().then {
    $0.backgroundColor = .ozet.gray1
  }

  // MARK: Init
  init() {
    super.init(frame: .zero)

    self.configureSubViews()

    self.contentStackView.addArrangedSubview(
      ResumeListHeaderContentView(title: "이름", content: "조유미")
    )
    self.contentStackView.addArrangedSubview(
      ResumeListHeaderContentView(title: "전화번호", content: "01083292719")
    )
    self.contentStackView.addArrangedSubview(
      ResumeListHeaderContentView(title: "닉네임", content: "윰")
    )
    self.contentStackView.addArrangedSubview(
      ResumeListHeaderContentView(title: "생년월일", content: "1997.04.22")
    )
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.profileImageView)
    self.addSubview(self.updateLabel)
    self.addSubview(self.titleLabel)
    self.addSubview(self.contentStackView)
    self.addSubview(self.bottomLineView)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.snp.makeConstraints { make in
      make.width.equalToSuperview()
    }

    self.profileImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(20)
      make.size.equalTo(Metric.profileViewSize)
    }

    self.updateLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(self.profileImageView.snp.bottom).offset(20)
      make.height.equalTo(14)
    }

    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.updateLabel.snp.bottom).offset(30)
      make.leading.equalToSuperview().inset(20)
    }

    self.contentStackView.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
    }

    self.bottomLineView.snp.makeConstraints { make in
      make.top.equalTo(self.contentStackView.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(10)
      make.bottom.equalToSuperview().inset(20)
    }
  }
}
