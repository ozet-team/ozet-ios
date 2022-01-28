//
//  PhoneAuthVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/02.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class PhoneAuthVC: BaseVC, View {
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
  
  // MARK: Init
  init(reactor: PhoneAuthReactor) {
    super.init()
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.phoneTextField.becomeFirstResponder()
  }
  
  // MARK: Bind
  func bind(reactor: PhoneAuthReactor) {
    self.input(reactor: reactor)
    self.output(reactor: reactor)
  }
  
  private func input(reactor: PhoneAuthReactor) {
    self.bottomButton.rx.tap
      .map { .nextProgress }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.phoneTextField.rx.textUpdated
      .map { .updatePhone($0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.authCodeTextField.rx.textUpdated
      .map { .updateAuthCode($0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  private func output(reactor: PhoneAuthReactor) {
    reactor.state.map(\.editState)
      .distinctUntilChanged()
      .bind { [weak self] state in
        self?.updateState(state: state)
      }
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.isCompleteLogin)
      .filter { $0 }
      .bind { [weak self] _ in
        self?.presentUserInfo()
      }
      .disposed(by: self.disposeBag)
  }

  // MARK: Presentaion
  private func presentAuthCodeView() {
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
  }
  
  private func presentUserInfo() {
    let infoVC = MyInfoVC()
    infoVC.modalPresentationStyle = .fullScreen
    self.present(infoVC, animated: true, completion: nil)
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
  
  private func updateState(state: PhoneAuthState) {
    self.bottomButton.text = state.buttonTitle
    self.bottomButton.isEnabled = state.isNextPrograssEnable
    
    if state == .typingAuthCode {
      self.presentUserInfo()
    }
  }
}
