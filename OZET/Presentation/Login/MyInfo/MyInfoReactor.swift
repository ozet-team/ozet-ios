//
//  MyInfoReactor.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/09.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import ReactorKit

final class MyInfoReactor: Reactor {
  
  enum Action {
    case updateName(String?)
    case done
  }
  
  enum Mutation {
    case setName(String?)
    case setIsNeedFinish
  }
  
  struct State {
    var name: String?
    var isNeedFinish = false
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
    case .updateName(let name):
      return .just(.setName(name))
    case .done:
      guard let name = self.currentState.name else {
        return .empty()
      }
      return self.userService.updateName(name: name)
        .filter { $0 }
        .map { _ in .setIsNeedFinish }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setName(let name):
      newState.name = name
      
    case .setIsNeedFinish:
      newState.isNeedFinish = true
    }
    
    return newState
  }
}
