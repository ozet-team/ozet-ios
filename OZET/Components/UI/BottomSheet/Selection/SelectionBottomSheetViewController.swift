//
//  SelectionBottomSheetViewController.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

import ReusableKit
import RxSwift
import RxCocoa

protocol SelectableItem {
  var name: String { get }
}

extension Reactive where Base: SelectionBottomSheetViewController {
  var itemSelected: ControlEvent<IndexPath> {
    base.tableView.rx.itemSelected
  }
}

final class SelectionBottomSheetViewController: BaseVC {
  typealias Item = SelectableItem

  // MARK: Constants
  private enum Reusable {
    static let cell = ReusableCell<SelectionBottomSheetCell>()
  }

  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.font = .ozet.header3
    $0.textColor = .ozet.blackWithDark
  }

  fileprivate let tableView = UITableView().then {
    $0.rowHeight = 44
    $0.register(Reusable.cell)
    $0.separatorStyle = .none
    $0.bounces = false
    $0.showsVerticalScrollIndicator = false
  }

  // MARK: Properties
  private let items: [Item]
  private let selectedItem: Item?

  // MARK: Initializer
  init(title: String, items: [Item], selectedItem: Item?) {
    self.items = items
    self.selectedItem = selectedItem
    super.init()

    self.titleLabel.text = title
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubviews()
    self.configureTableView()
  }

  // MARK: Configuartion
  private func configureSubviews() {
    self.view.backgroundColor = .ozet.whiteWithDark
    self.view.addSubview(self.titleLabel)
    self.view.addSubview(self.tableView)
  }

  private func configureTableView() {
    Observable.just(self.items)
      .bind(to: self.tableView.rx.items(Reusable.cell)) { _, item, cell in
        cell.bind(title: item.name)
      }
      .disposed(by: self.disposeBag)

    self.tableView.rx.itemSelected
      .withUnretained(self)
      .bind { (self, _) in
        self.dismiss(animated: true)
      }
      .disposed(by: self.disposeBag)
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.titleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(36)
    }

    self.tableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
      make.bottom.equalToSuperview()
    }
  }
}

extension SelectionBottomSheetViewController: BottomSheetProtocol {
  var halfContentHeight: CGFloat {
    CGFloat(70) + CGFloat(self.items.count * 44)
  }

  var trackedScrollView: UIScrollView? {
    self.tableView
  }
}
