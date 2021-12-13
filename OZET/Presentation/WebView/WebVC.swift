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

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
    self.configureWebView()

  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.webView)
  }

  private func configureWebView() {
    if let url = URL(string: Constants.base) {
      self.webView.load(URLRequest(url: url))
    }
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.webView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
