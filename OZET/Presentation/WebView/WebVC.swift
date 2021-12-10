//
//  WebVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import UIKit
import WebKit

import RxCocoa
import RxSwift
import RxKeyboard

final class WebVC: BaseVC {

  private enum Constants {
    static let base = "https://hybrid.ozet.app/#/list/all?_si=1"
  }

  // MARK: UI Components
  private let webView = WKWebView().then {
    $0.scrollView.bounces = false
  }

  private let buttonStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10
  }

  private let closeButton = UIButton().then {
    $0.setTitle("닫기", for: .normal)
    $0.setTitleColor(.black, for: .normal)
  }
  private let searchTextField = UITextField().then {
    $0.alpha = 0.5
    $0.layer.cornerRadius = 5
    $0.layer.borderColor = UIColor.ozet.black.cgColor
    $0.layer.borderWidth = 1
    $0.text = Constants.base
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
    self.configureWebView()
    self.configureKeyboard()
    self.bind()

  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.webView)

    self.view.addSubview(self.buttonStackView)
    self.buttonStackView.addArrangedSubview(self.searchTextField)
    self.buttonStackView.addArrangedSubview(self.closeButton)
  }

  private func configureWebView() {
    if let url = URL(string: Constants.base) {
      self.webView.load(URLRequest(url: url))
    }
  }

  private func configureKeyboard() {
    RxKeyboard.instance.visibleHeight
      .throttle(0.3)
      .drive { [weak self] height in
        guard let self = self else { return }
        self.webView.snp.updateConstraints { make in
          make.bottom.equalToSuperview().inset(height)
        }
      }
      .disposed(by: self.disposeBag)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.webView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    self.buttonStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(50)
      make.bottom.equalTo(self.webView).inset(50)
    }
  }

  // MARK: Bind
  private func bind() {
    self.closeButton.rx.tap
      .bind { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
      .disposed(by: self.disposeBag)

    self.searchTextField.rx.controlEvent(.editingDidEndOnExit)
      .map { self.searchTextField.text }
      .bind { [weak self] url in
        if let request = URL(string: url ?? "") {
          self?.webView.load(URLRequest(url: request))
        }
      }
      .disposed(by: self.disposeBag)
  }
}
