//
//  AppDelegate.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/08/28.
//

import UIKit

import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

