//
//  BottomButton.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/02.
//

import UIKit
import RxKeyboard
import RxSwift
import RxCocoa

class BottomButton: BaseButton {
  // MARK: Constants
  private enum Metric {
    static let buttonCornerRadius: CGFloat = 11
    static let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
  }

  // MARK: Properties
  override var isEnabled: Bool {
    didSet {
      self.backgroundColor = self.isEnabled ? .ozet.purple : .ozet.gray1
    }
  }

  var text: String? {
    didSet {
      self.setTitle(self.text, for: .normal)
    }
  }

  // MARK: Init
  init() {
    super.init(frame: .zero)

    self.configureKeyboard()
    self.layer.cornerRadius = Metric.buttonCornerRadius
    self.setTitleColor(.ozet.white, for: .normal)
    self.setTitleColor(.ozet.gray3, for: .disabled)
    self.backgroundColor = .ozet.purple
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Configuration
  private func configureKeyboard() {
    RxKeyboard.instance.willShowVisibleHeight
      .skip(1)
      .drive { [weak self] height in
        self?.updateState(height: height, isAnimation: true)
      }
      .disposed(by: self.disposeBag)

    RxKeyboard.instance.visibleHeight
      .drive { [weak self] height in
        guard let self = self else { return }
        guard height == 0 else { return }
        guard self.didMakeConstraints else { return }
        self.updateState(height: height, isAnimation: true)
      }
      .disposed(by: self.disposeBag)
  }

  // MARK: Layout
  override func makeConstraints() {
    super.makeConstraints()

    self.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(5 + Metric.bottomInset)
      make.height.equalTo(58)
    }
  }

  private func updateState(height: CGFloat, isAnimation: Bool) {
    if height > 0 {
      self.snp.updateConstraints { make in
        make.leading.trailing.equalToSuperview()
        make.bottom.equalToSuperview().inset(height)
      }
      self.layer.cornerRadius = 0
    } else {
      self.snp.updateConstraints { make in
        make.leading.trailing.equalToSuperview().inset(20)
        make.bottom.equalToSuperview().inset(5 + Metric.bottomInset)
      }
      self.layer.cornerRadius = Metric.buttonCornerRadius
    }

    if isAnimation {
      UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut) {
        self.superview?.layoutIfNeeded()
      } completion: { _ in
      }

    } else {
      self.layoutIfNeeded()
    }
  }
}
