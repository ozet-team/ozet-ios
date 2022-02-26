//
//  ResumeListHeaderView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: ResumeListHeaderView {
  var userInfo: Binder<User> {
    Binder(self.base) { base, user in
      base.configure(user: user)
    }
  }
}

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
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
  
  fileprivate func configure(user: User) {
    if let name = user.name {
      self.contentStackView.addArrangedSubview(
        ResumeListHeaderContentView(title: "이름", content: name)
      )
    }
    
    self.contentStackView.addArrangedSubview(
      ResumeListHeaderContentView(title: "전화번호", content: user.phoneNumber)
    )
    
    self.contentStackView.addArrangedSubview(
      ResumeListHeaderContentView(title: "닉네임", content: user.username)
    )
    
    if let birthday = user.birthday {
      self.contentStackView.addArrangedSubview(
        ResumeListHeaderContentView(title: "생년월일", content: birthday)
      )
    }
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
