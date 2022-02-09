//
//  PhoneAuthReactor.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/01/24.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import ReactorKit

enum PhoneAuthState {
  case typingPhone
  case compeletePhone
  case typingAuthCode
  case compeleteAuthCode
  
  var isNextPrograssEnable: Bool {
    switch self {
    case .typingPhone, .typingAuthCode:
      return false
    case .compeletePhone, .compeleteAuthCode:
      return true
    }
  }
  
  var buttonTitle: String? {
    switch self {
    case .typingPhone, .compeletePhone:
      return R.string.ozet.loginButtonSendCode()
    case .typingAuthCode, .compeleteAuthCode:
      return R.string.ozet.commonDone()
    }
  }
}

final class PhoneAuthReactor: Reactor {
  
  enum Action {
    case nextProgress
    case updatePhone(String?)
    case updateAuthCode(String?)
  }
  
  enum Mutation {
    case setPhoneNumber(String?)
    case setAuthCode(String?)
    case setCompleteLogin(LoginResponse)
    case setRequestAuthCode(Date?)
    case setError(String)
  }
  
  struct State {
    var editState = PhoneAuthState.typingPhone
    var phoneNumber: String?
    var authCode: String?
    var isCompleteLogin = false
    var isNeedUserName = false
    var expireTime: Date?
    var isNeedAlert: String?
  }
  
  // MARK: Properties
  var initialState: State = State()
  private let userService: UserService
  
  // MARK: Init
  init(userService: UserService) {
    self.userService = userService
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .nextProgress:
      if self.currentState.editState == .compeletePhone {
        return self.requestAuthCode(phone: self.currentState.phoneNumber ?? "")
      }
      
      if self.currentState.editState == .compeleteAuthCode {
        return self.checkAuthCode(
          phone: self.currentState.phoneNumber ?? "",
          code: self.currentState.authCode ?? ""
        )
      }
      
      return .empty()
    case .updatePhone(let phone):
      return .just(.setPhoneNumber(phone))
    case .updateAuthCode(let authCode):
      return .just(.setAuthCode(authCode))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    newState.isNeedAlert = nil
    
    switch mutation {
    case .setPhoneNumber(let phone):
      newState.phoneNumber = phone
      if let phone = phone, phone.count > 9 {
        newState.editState = .compeletePhone
      } else {
        newState.editState = .typingPhone
      }
    case .setAuthCode(let authCode):
      newState.authCode = authCode
      if let authCode = authCode, authCode.count > 5 {
        newState.editState = .compeleteAuthCode
      } else {
        newState.editState = .typingAuthCode
      }
    case .setCompleteLogin(let response):
      newState.isCompleteLogin = response.user.name != nil
      newState.isNeedUserName = response.user.name == nil
    case .setRequestAuthCode(let expiredAt):
      newState.expireTime = expiredAt
      newState.editState = .typingAuthCode
      newState.authCode = nil
    case .setError(let error):
      newState.isNeedAlert = error
    }
    return newState
  }
  
  private func requestAuthCode(phone: String) -> Observable<Mutation> {
    self.userService.requestAuthCode(phone: phone)
      .map { .setRequestAuthCode($0) }
      .catchAndReturn(.setError("메세지 전송에 실패했습니다\n다시시도 해주세요"))
  }
  
  private func checkAuthCode(phone: String, code: String) -> Observable<Mutation> {
    self.userService.sendAuthCode(phone: phone, code: code)
      .map { .setCompleteLogin($0) }
      .catchAndReturn(.setError("로그인에 실패했습니다\n다시시도 해주세요"))
  }
  
  func makeMyInfoReactor() -> MyInfoReactor {
    MyInfoReactor(userService: self.userService)
  }
}
