//
//  MainVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit

final class MainVC: BaseVC {

  // MARK: UI Components
  private let titleView = UIView()
  private let infoView = UIView()
  private let containerView = ScrollableStackView(spacing: 30)
  private let firstList = MainRecruitPostListView()
  private let secondList = MainRecruitPostListView()
  private let thirdList = MainRecruitPostListView()

  private let logoView = UIImageView().then {
    $0.image = R.image.splashLogo()
    $0.contentMode = .scaleAspectFit
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.titleView)
    self.view.addSubview(self.containerView)

    self.titleView.addSubview(self.logoView)

    self.containerView.addStackView([
      self.infoView,
      self.firstList,
      self.secondList,
      self.thirdList
    ])
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.titleView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.height.equalTo(44)
    }

    self.logoView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(5)
      make.width.equalTo(60)
    }

    self.containerView.snp.makeConstraints { make in
      make.top.equalTo(self.titleView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }

    self.infoView.snp.makeConstraints { make in
      make.height.equalTo(150)
    }
  }
}