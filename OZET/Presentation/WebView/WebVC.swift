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
    static let interface = "callbackHandler"
  }

  private enum WebRequest: String {
    case back = "back"
    case swipe = "swipe"
    case token = "token"
    case login = "login"
  }

  private struct WebEvent: Decodable {
    let event: String
    let isEnableSwipe: Bool?
  }

  // MARK: UI Components
  private var webView: WKWebView!
  
  // MARK: Property
  private let path: String!

  // MARK: Initializer
  init(url: String) {
    self.path = url
    super.init()
    let configuration = WKWebViewConfiguration()
    let controller = WKUserContentController()
    controller.add(self, name: Constants.interface)
    configuration.userContentController = controller
    self.webView = WKWebView(frame: .zero, configuration: configuration).then {
      $0.scrollView.bounces = false
    }
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
  
  // MARK: Event
  private func sendToken() {
    guard let token = UserDefaults.standard.string(forKey: "token") else { return }
    self.webView.evaluateJavaScript("window.setAccessToken(\"\(token)\")", completionHandler: nil)
  }
  
  // MARK: Present
  private func presentLogin() {
    let reactor = PhoneAuthReactor(
      userService: UserServiceImpl(
        userProvider: UserProvider()
      )
    )
    let vc = PhoneAuthVC(reactor: reactor) {
      self.sendToken()
    }
    let navigation = UINavigationController(rootViewController: vc)
    navigation.isNavigationBarHidden = true
    self.present(navigation, animated: true, completion: nil)
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

    case .token:
      self.sendToken()
      
    case .login:
      self.presentLogin()
    }
  }
}
