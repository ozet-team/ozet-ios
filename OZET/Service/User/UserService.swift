//
//  UserService.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/01/28.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import RxSwift

protocol UserService: AnyObject {
  func requestAuthCode(phone: String) -> Observable<Date?>
  func sendAuthCode(phone: String, code: String) -> Observable<LoginResponse>
  func updateName(name: String) -> Observable<Bool>
}

final class UserServiceImpl: UserService {
  
  // MARK: Property
  private let userProvider: UserProvider
  
  // MARK: Init
  init(userProvider: UserProvider) {
    self.userProvider = userProvider
  }
  
  func requestAuthCode(phone: String) -> Observable<Date?> {
    self.userProvider.rx.request(.sendSMS(phone: "+82" + phone))
      .map(VerifyResponse.self)
      .map(\.expireAt)
      .asObservable()
  }
  
  func sendAuthCode(phone: String, code: String) -> Observable<LoginResponse> {
    self.userProvider.rx.request(.authSMS(phone: "+82" + phone, code: code))
      .map(LoginResponse.self)
      .do(onSuccess: { response in
        UserDefaults.standard.set(response.token, forKey: "token")
        UserDefaults.standard.synchronize()
      })
      .asObservable()
  }
  
  
  func updateName(name: String) -> Observable<Bool> {
    self.userProvider.rx.request(.updateName(name: name))
      .map(User.self)
      .debug()
      .map { $0.name != nil }
      .asObservable()
  }
  
}
