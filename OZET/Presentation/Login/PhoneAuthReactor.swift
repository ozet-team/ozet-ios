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
    case setCompleteLogin(Bool)
    case setRequestAuthCode
    case setCheckAuthCode(Bool)
  }
  
  struct State {
    var editState = PhoneAuthState.typingPhone
    var phoneNumber: String?
    var authCode: String?
    var isCompleteLogin = false
  }
  
  // MARK: Properties
  var initialState: State = State()
  
  // MARK: Init
  init() {
    
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
    case .setCompleteLogin(let isComplete):
      newState.isCompleteLogin = isComplete
    case .setRequestAuthCode:
      newState.editState = .typingAuthCode
      newState.authCode = nil
    case .setCheckAuthCode(let result):
      newState.isCompleteLogin = result
    }
    
    return newState
  }
  
  private func requestAuthCode(phone: String) -> Observable<Mutation> {
    .just(.setRequestAuthCode)
  }
  
  private func checkAuthCode(phone: String, code: String) -> Observable<Mutation> {
    .just(.setCompleteLogin(true))
  }
}
