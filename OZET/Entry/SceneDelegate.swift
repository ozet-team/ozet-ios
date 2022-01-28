//
//  SceneDelegate.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/08/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = PhoneAuthVC(reactor: PhoneAuthReactor())
    self.window = window
    self.window?.makeKeyAndVisible()
  }
}

