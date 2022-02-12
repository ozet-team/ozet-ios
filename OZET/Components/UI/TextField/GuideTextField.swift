//
//  GuideTextField.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: GuideTextField {
  var textUpdated: ControlEvent<String?> {
    let event = self.base.textField.rx.controlEvent(.editingChanged)
      .withLatestFrom(self.base.textField.rx.text)
    return ControlEvent(events: event)
  }
}

final class GuideTextField: BaseView {
  // MARK: UI Components
  private let titleLabel = UILabel().then {
    $0.textColor = .ozet.blackWithDark
    $0.font = .systemFont(ofSize: 16)
  }

  fileprivate let textField = UITextField().then {
    $0.textColor = .ozet.blackWithDark
    $0.tintColor = .ozet.blackWithDark
    $0.font = .systemFont(ofSize: 16)
  }

  private let bottomLine = UIView().then {
    $0.backgroundColor = .darkGray
  }

  private let highlightedBottomLine = UIView().then {
    $0.backgroundColor = .ozet.blackWithDark
  }

  // MARK: Initializer
  init(title: String, placeholder: String, type: UIKeyboardType) {
    super.init(frame: .zero)
    self.configureSubViews()
    self.configureEditing()

    self.titleLabel.text = title
    self.textField.placeholder = placeholder
    self.textField.keyboardType = type
    self.backgroundColor = .ozet.whiteWithDark
  }

  required init?(coder: NSCoder) {
    fatalError("")
  }

  private func configureEditing() {
    self.textField.rx.controlEvent(.editingDidBegin)
      .bind { [weak self] _ in
        self?.updateLineState(isEditing: true)
      }
      .disposed(by: self.disposeBag)

    self.textField.rx.controlEvent(.editingDidEnd)
      .bind { [weak self] _ in
        self?.updateLineState(isEditing: false)
      }
      .disposed(by: self.disposeBag)
  }
  
  override func becomeFirstResponder() -> Bool {
    self.textField.becomeFirstResponder()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.titleLabel)
    self.addSubview(self.textField)
    self.addSubview(self.bottomLine)
    self.addSubview(self.highlightedBottomLine)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.snp.makeConstraints { make in
      make.height.equalTo(78)
    }

    self.titleLabel.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
    }

    self.textField.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview()
      make.height.equalTo(50)
    }

    self.bottomLine.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview()
      make.height.equalTo(1)
    }

    self.highlightedBottomLine.snp.makeConstraints { make in
      make.leading.bottom.equalToSuperview()
      make.width.equalTo(0)
      make.height.equalTo(1)
    }
  }

  private func updateLineState(isEditing: Bool) {
    self.highlightedBottomLine.snp.remakeConstraints { make in
      if isEditing {
        make.width.equalTo(self.snp.width)
      } else {
        make.width.equalTo(0)
      }
      make.leading.bottom.equalToSuperview()
      make.height.equalTo(1)
    }

    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}
