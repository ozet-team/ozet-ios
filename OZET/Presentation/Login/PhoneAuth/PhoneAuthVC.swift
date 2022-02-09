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
  private let closeButton = UIButton().then {
    $0.setImage(R.image.iconClose(), for: .normal)
  }
  
  private let bottomButton = BottomButton().then {
    $0.text = R.string.ozet.loginButtonSendCode()
  }

  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 10
  }
  
  private let textFieldStackView = UIStackView().then {
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
  
  private let timerView = PhoneAuthTimerView().then {
    $0.isHidden = true
  }
  
  // MARK: Handler
  var complition: (() -> Void)?
  
  // MARK: Init
  init(reactor: PhoneAuthReactor, complition: (() -> Void)?) {
    super.init()
    self.reactor = reactor
    self.complition = complition
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
    self.closeButton.rx.tap
      .bind { [weak self] _ in
        self?.navigationController?.dismiss(animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
    
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
        self?.complition?()
        self?.navigationController?.dismiss(animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.isNeedUserName)
      .filter { $0 }
      .bind { [weak self] _ in
        self?.presentUserInfo()
      }
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.expireTime)
      .distinctUntilChanged()
      .bind(to: self.timerView.rx.startTimer)
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.isNeedAlert)
      .compactMap { $0 }
      .withUnretained(self)
      .bind { (self, message) in
        self.presentErrorMessage(message: message)
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
    guard let reactor = self.reactor?.makeMyInfoReactor() else { return }
    let infoVC = MyInfoVC(reactor: reactor, complition: self.complition)
    self.navigationController?.show(infoVC, sender: nil)
  }
  
  private func presentErrorMessage(message: String?) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let done = UIAlertAction(title: R.string.ozet.commonDone(), style: .default, handler: nil)
    alert.addAction(done)
    self.present(alert, animated: true, completion: nil)
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.contentStackView)
    self.view.addSubview(self.closeButton)
    self.contentStackView.addArrangedSubview(self.textFieldStackView)
    self.contentStackView.addArrangedSubview(self.timerView)
    
    self.textFieldStackView.addArrangedSubview(self.phoneTextField)
    self.textFieldStackView.addArrangedSubview(self.authCodeTextField)
    self.textFieldStackView.bringSubviewToFront(self.phoneTextField)

    self.view.addSubview(self.bottomButton)
  }

  override func makeConstraints() {
    super.makeConstraints()
    
    self.closeButton.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().inset(20)
      make.size.equalTo(30)
    }

    self.contentStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(100)
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }
  
  private func updateState(state: PhoneAuthState) {
    self.bottomButton.text = state.buttonTitle
    self.bottomButton.isEnabled = state.isNextPrograssEnable
    
    if state == .typingAuthCode {
      self.presentAuthCodeView()
    }
  }
}
