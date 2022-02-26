//
//  ResumeListVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import ReusableKit
import ReactorKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxDataSources

final class ResumeListVC: BaseVC, View {

  // MARK: Constants

  private enum Reusable {
    static let defaultCell = ReusableCell<ResumeListDefaultCell>()
    static let defaultAddCell = ReusableCell<ResumeListDefaultAddCell>()
    static let multilineCell = ReusableCell<ResumeListMultilineCell>()
    static let headerView = ReusableView<ResumeListSectionHeaderView>()
  }

  // MARK: UI Components
  private let navigationBar: NavigationBar

  private let tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.separatorStyle = .none
    $0.sectionHeaderHeight = 40
    $0.backgroundColor = .clear
    $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    $0.register(Reusable.defaultCell)
    $0.register(Reusable.defaultAddCell)
    $0.register(Reusable.multilineCell)
    $0.register(Reusable.headerView)
  }

  private let headerView = ResumeListHeaderView()
  
  private let dataSource = RxTableViewSectionedReloadDataSource<ResumeListData> { _, tableView, indexPath, item in
    switch item {
    case .defaultItem(let item):
      return tableView.dequeue(Reusable.defaultCell, for: indexPath).then {
        $0.configure(item: item)
      }

    case .addItem:
      return tableView.dequeue(Reusable.defaultAddCell, for: indexPath)
      
    case .multilineItem(let content):
      return tableView.dequeue(Reusable.multilineCell, for: indexPath).then {
        $0.configure(content: content)
      }
    }
  }

  // MARK: Initializer
  init(reactor: ResumeListReactor) {
    self.navigationBar = NavigationBar()
    super.init()
    self.reactor = reactor
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
  func bind(reactor: ResumeListReactor) {
    self.input(reactor: reactor)
    self.output(reactor: reactor)
  }
  
  private func input(reactor: ResumeListReactor) {
    self.navigationBar.rx.tapBack
      .withUnretained(self)
      .bind { (self, _) in
        self.navigationController?.popViewController(animated: true)
      }
      .disposed(by: self.disposeBag)
    
    self.rx.viewWillAppear
      .map { _ in .loadResume }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  private func output(reactor: ResumeListReactor) {
    reactor.state.map(\.data)
      .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.userInfo)
      .compactMap { $0 }
      .bind(to: self.headerView.rx.userInfo)
      .disposed(by: self.disposeBag)
  }
}

extension ResumeListVC: UITableViewDelegate {

  func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    guard !self.dataSource.sectionModels.isEmpty
    else {
      return nil
    }
    let title = self.dataSource[section].type.title
    let headerView = tableView.dequeue(Reusable.headerView)
    headerView?.configure(title: title)
    return headerView
  }

  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let item = self.dataSource[indexPath.section].items[indexPath.item]
    let width = tableView.frame.width
    switch item {
    case .defaultItem:
      return 80

    case .addItem:
      return 68
      
    case .multilineItem(let content):
      return ResumeListMultilineCell.getHeight(content: content, width: width)
    }
  }
}
