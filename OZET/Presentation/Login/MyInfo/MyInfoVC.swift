//
//  MyInfoVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/11/28.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class MyInfoVC: BaseVC, View {

  // MARK: UI Components
  private let closeButton = UIButton().then {
    $0.setImage(R.image.iconClose(), for: .normal)
  }
  
  private let bottomButton = BottomButton().then {
    $0.text = R.string.ozet.commonDone()
    $0.isEnabled = false
  }

  private let nameTextField = GuideTextField(
    title: R.string.ozet.nameTextFieldTitle(),
    placeholder: R.string.ozet.nameTextFieldPlaceholder(),
    type: .default
  )
  
  // MARK: Handler
  var complition: (() -> Void)?
  
  // MARK: Init
  init(reactor: MyInfoReactor, complition: (() -> Void)?) {
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
  
  // MARK: Bind
  func bind(reactor: MyInfoReactor) {
    self.input(reactor: reactor)
    self.output(reactor: reactor)
  }
  
  private func input(reactor: MyInfoReactor) {
    self.closeButton.rx.tap
      .bind { [weak self] _ in
        self?.navigationController?.dismiss(animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
    
    self.nameTextField.rx.textUpdated
      .map {
        .updateName($0)
      }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.bottomButton.rx.tap
      .map {
        .done
      }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  private func output(reactor: MyInfoReactor) {
    reactor.state.map(\.name)
      .compactMap { $0 }
      .map { !$0.isEmpty }
      .bind(to: self.bottomButton.rx.isEnabled)
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.isNeedFinish)
      .filter { $0 }
      .bind { [weak self] _ in
        self?.complition?()
        self?.navigationController?.dismiss(animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.nameTextField)
    self.view.addSubview(self.bottomButton)
    self.view.addSubview(self.closeButton)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.nameTextField.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(100)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    self.closeButton.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().inset(20)
      make.size.equalTo(30)
    }
  }
}
