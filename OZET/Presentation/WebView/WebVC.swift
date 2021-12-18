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

  // MARK: Constants
  private enum Constants {
    static let base = "https://hybrid.ozet.app/#/list/all?_si=1"
    static let interface = "app"
  }

  private enum WebRequest: String {
    case back = "back"
    case swipe = "isEnableSwipe"
  }

  private struct WebEvent: Decodable {
    let event: String
    let isEnableSwipe: Bool?
  }

  // MARK: UI Components
  private let webView: WKWebView

  // MARK: Initializer
  override init() {
    let configuration = WKWebViewConfiguration()
    let controller = WKUserContentController()
    configuration.userContentController = controller
    self.webView = WKWebView(frame: .zero, configuration: configuration).then {
      $0.scrollView.bounces = false
    }
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
    self.configureWebView()
  }

  // MARK: Configure
  private func configureSubViews() {
    self.view.addSubview(self.webView)
  }

  private func configureWebView() {
    self.webView.configuration.userContentController.add(
      self,
      name: Constants.interface
    )

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

extension WebVC: WKScriptMessageHandler {
  func userContentController(
    _ userContentController: WKUserContentController,
    didReceive message: WKScriptMessage
  ) {
    guard let body = message.body as? String,
          let data = body.data(using: .utf8),
          let event = try? JSONDecoder().decode(WebEvent.self, from: data),
          let eventType = WebRequest(rawValue: event.event)
    else {
      return
    }

    switch eventType {
    case .back:
      self.navigationController?.popViewController(animated: true)

    case .swipe:
      self.navigationController?.interactivePopGestureRecognizer?.isEnabled = event.isEnableSwipe ?? true
    }
  }
}
