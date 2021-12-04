//
//  PhoneAuthVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/02.
//

import UIKit

final class PhoneAuthVC: BaseVC {
  // MARK: UI Components
  private let bottomButton = BottomButton().then {
    $0.text = R.string.ozet.loginButtonSendCode()
  }

  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 40
  }

  private let phoneTextField = GuideTextField(
    title: R.string.ozet.loginPhoneTextFieldTitle(),
    placeholder: R.string.ozet.loginPhonePlaceholder(),
    type: .decimalPad
  )

  private let authCodeTextField = GuideTextField(
    title: R.string.ozet.loginAuthCodeTextFieldTitle(),
    placeholder: R.string.ozet.loginAuthCodePlaceholder(),
    type: .decimalPad
  ).then {
    $0.isHidden = true
    $0.alpha = 0
    $0.layer.zPosition = 0
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()

    self.bottomButton.rx.tap
      .bind { [weak self] in
        self?.presentAuthCodeView()
      }
      .disposed(by: self.disposeBag)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.phoneTextField.becomeFirstResponder()
  }

  // MARK: Presentaion
  private func presentAuthCodeView() {
    if self.authCodeTextField.isHidden {
      UIViewPropertyAnimator.runningPropertyAnimator(
        withDuration: 0.5,
        delay: 0,
        options: [.curveEaseOut]) {
          self.authCodeTextField.isHidden = false
          self.authCodeTextField.alpha = 1
          self.contentStackView.layoutIfNeeded()
        } completion: { _ in
          self.authCodeTextField.becomeFirstResponder()
        }
    } else {
      let infoVC = MyInfoVC()
      infoVC.modalPresentationStyle = .fullScreen
      self.present(infoVC, animated: true, completion: nil)
    }
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.contentStackView)
    self.contentStackView.addArrangedSubview(self.phoneTextField)
    self.contentStackView.addArrangedSubview(self.authCodeTextField)
    self.contentStackView.bringSubviewToFront(self.phoneTextField)

    self.view.addSubview(self.bottomButton)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.contentStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(100)
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }
}
