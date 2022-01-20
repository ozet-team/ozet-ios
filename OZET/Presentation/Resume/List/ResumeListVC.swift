//
//  ResumeListVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import ReusableKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxDataSources

final class ResumeListVC: BaseVC {

  // MARK: Constants

  private enum Reusable {
    static let defaultCell = ReusableCell<ResumeListDefaultCell>()
    static let defaultAddCell = ReusableCell<ResumeListDefaultAddCell>()
    static let headerView = ReusableView<ResumeListSectionHeaderView>()
  }

  // MARK: UI Components
  private let navigationBar: NavigationBar

  private let tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.separatorStyle = .none
    $0.sectionHeaderHeight = 40
    $0.backgroundColor = .clear
    $0.register(Reusable.defaultCell)
    $0.register(Reusable.defaultAddCell)
    $0.register(Reusable.headerView)
  }

  private let headerView = ResumeListHeaderView()

  // MARK: Mock Data
  private let data = [
    ResumeListData(title: "경력", items: [
      .defaultItem(ResumeDefaultItem(id: 1, name: "샵 이름이 보여집니다 길어지면은 자동으로 줄여지겠지???", date: "2000.00.00"))
    ]),
    ResumeListData(title: "자격증", items: [
      .defaultItem(ResumeDefaultItem(id: 2, name: "미용자격증", date: "2000.00.00")),
      .defaultItem(ResumeDefaultItem(id: 25, name: "점장자격증", date: "2000.00.00"))
    ]),
    ResumeListData(title: "병역", items: [
      .defaultItem(ResumeDefaultItem(id: 3, name: "컬리페이", date: "2022.01.01 ~ 2025.03.01"))
    ]),
    ResumeListData(title: "주소", items: [
      .defaultItem(ResumeDefaultItem(id: 4, name: "서울시 동대문구 장안동", date: nil))
    ]),
    ResumeListData(title: "자기소개", items: [
      .addItem
    ]),
    ResumeListData(title: "인스타그램", items: [
      .addItem
    ])
  ]

  // MARK: Initializer
  override init() {
    self.navigationBar = NavigationBar()
    super.init()

    self.navigationBar.rx.tapBack
      .withUnretained(self)
      .bind { (self, _) in
        self.navigationController?.popViewController(animated: true)
      }
      .disposed(by: self.disposeBag)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubView()
    self.configureTableView()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    self.tableView.tableHeaderView?.frame = CGRect(
      origin: .zero,
      size: CGSize(width: self.tableView.frame.width, height: 414)
    )
  }

  // MARK: Configure
  private func configureSubView() {
    self.view.addSubview(self.navigationBar)
    self.view.addSubview(self.tableView)
  }

  private func configureTableView() {
    self.tableView.tableHeaderView = self.headerView
    self.headerView.setNeedsLayout()
    self.headerView.layoutIfNeeded()
    self.headerView.frame.size = self.headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    self.tableView.tableHeaderView = self.headerView

    self.tableView.rx.setDelegate(self)
      .disposed(by: self.disposeBag)

    let dataSource = RxTableViewSectionedAnimatedDataSource<ResumeListData> { _, tableView, indexPath, item in
      switch item {
      case .defaultItem(let item):
        return tableView.dequeue(Reusable.defaultCell, for: indexPath).then {
          $0.configure(item: item)
        }

      case .addItem:
        return tableView.dequeue(Reusable.defaultAddCell, for: indexPath)
      }
    }

    Observable.just(self.data)
      .bind(to: self.tableView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.navigationBar.snp.makeConstraints { make in
      make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
    }

    self.tableView.snp.makeConstraints { make in
      make.top.equalTo(self.navigationBar.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }

  // MARK: Bind
  private func input() {
    self.navigationBar.rx.tapBack
      .withUnretained(self)
      .bind { (self, _) in
        self.navigationController?.popViewController(animated: true)
      }
      .disposed(by: self.disposeBag)
  }
}

extension ResumeListVC: UITableViewDelegate {

  func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    tableView.dequeue(Reusable.headerView)?.then {
      $0.configure(title: self.data[section].title)
    }
  }

  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let item = self.data[indexPath.section].items[indexPath.item]
    switch item {
    case .defaultItem:
      return 80

    case .addItem:
      return 68
    }
  }
}
