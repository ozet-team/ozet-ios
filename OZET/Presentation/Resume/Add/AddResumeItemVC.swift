//
//  AddResumeItemVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxKeyboard

final class AddResumeItemVC: BaseVC {

  // MARK: UI Components
  private let navigationBar: NavigationBar

  private let stackView = ScrollableStackView(spacing: 30).then {
    $0.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
  }

  // MARK: Properties
  private let type: ResumeAddType

  // MARK: Initializer
  init(type: ResumeAddType) {
    self.navigationBar = NavigationBar(title: type.title)
    self.type = type
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubView()
    self.configureType()
    self.configureKeyboard()
    self.input()
  }

  // MARK: Configure
  private func configureSubView() {
    self.view.addSubview(self.navigationBar)
    self.view.addSubview(self.stackView)
  }

  private func configureType() {
    for component in self.type.components {
      switch component {
      case .selectionField(let resumeSelectionFieldType):
        guard let view = component.view as? ResumeSelectionField else { return }
        view.rx.tap
          .withUnretained(self)
          .bind { (self, _ ) in
            self.presentBottomSheet(options: resumeSelectionFieldType.options)
          }
          .disposed(by: self.disposeBag)
        self.stackView.addStackView([view])
      default:
        self.stackView.addStackView([component.view])
      }
    }
  }

  private func configureKeyboard() {
    RxKeyboard.instance.visibleHeight
      .withUnretained(self)
      .drive { (self, height) in
        self.stackView.snp.updateConstraints { make in
          make.bottom.equalToSuperview().inset(height)
        }
      }
      .disposed(by: self.disposeBag)
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.navigationBar.snp.makeConstraints { make in
      make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
    }

    self.stackView.snp.makeConstraints { make in
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

  // MARK: Presentaion
  private func presentBottomSheet(options: [SelectableItem]) {
    let controller = SelectionBottomSheetViewController(
      title: "직급 선택",
      items: options,
      selectedItem: nil
    )
    let bottomSheet = BottomSheetViewController(contentViewController: controller)
    self.present(bottomSheet, animated: true, completion: nil)
  }
}
