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
    
    UserDefaults.standard.set("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5LCJ1c2VybmFtZSI6Im96ZXRfZDE2MDY2ZjA5YjU5NDI3NmJiN2Q5NjI4ZTVlYTE1NjQiLCJleHAiOjE2NDYyMDEzNDl9.CQfCd1VtNL051mvnHq2-OzqHe5nbpte_6bWXqfi7aJ0", forKey: "token")
    UserDefaults.standard.synchronize()

    let window = UIWindow(windowScene: windowScene)
    let reactor = MainReactor(
      announcementService: AnnouncementServiceImpl(
        provider: AnnouncementProvider()
      )
    )
    let controller = MainVC(reactor: reactor)
    let navigationController = UINavigationController(rootViewController: controller)
    navigationController.modalPresentationStyle = .fullScreen
    navigationController.isNavigationBarHidden = true
    navigationController.interactivePopGestureRecognizer?.delegate = nil
    
    window.rootViewController = navigationController
    self.window = window
    self.window?.makeKeyAndVisible()
  }
}

