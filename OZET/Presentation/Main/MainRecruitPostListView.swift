//
//  MainRecruitPostListView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit

import RxCocoa
import RxSwift
import ReusableKit

extension Reactive where Base: MainRecruitPostListView {
  var tapMore: ControlEvent<Void> {
    self.base.moreButton.rx.tap
  }
}

enum MainRecruitPostType {
  case all
  case recommend
  
  var title: String {
    switch self {
    case .all:
      return "모든 공고"
    case .recommend:
      return "추천 공고"
    }
  }
}

final class MainRecruitPostListView: BaseView {
  // MARK: Constants
  private enum Reusable {
    static let cell = ReusableCell<RecruitPostCell>()
  }

  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.textColor = .ozet.blackWithDark
    $0.font = .systemFont(ofSize: 16, weight: .bold)
  }

  fileprivate let moreButton = UIButton().then {
    $0.setTitleColor(.ozet.blackWithDark, for: .normal)
    $0.setTitle("더보기", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 13)
  }

  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then({
      $0.scrollDirection = .horizontal
    })
  ).then {
    $0.register(Reusable.cell)
    $0.backgroundColor = .clear
    $0.showsHorizontalScrollIndicator = false
    $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }

  // MARK: Init
  init(type: MainRecruitPostType) {
    super.init(frame: .zero)

    self.titleLabel.text = type.title
    self.configureSubViews()
    self.configureCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.moreButton)
    self.addSubview(self.collectionView)
  }

  private func configureCollectionView() {
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview()
    }

    self.moreButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(20)
      make.centerY.equalTo(self.titleLabel)
    }

    self.collectionView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(35)
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(206)
    }
  }
}

extension MainRecruitPostListView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    10
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeue(Reusable.cell, for: indexPath)

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    CGSize(width: 174, height: 171)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    16
  }
}
