//
//  ResumeListReactor.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/26.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import ReactorKit

final class ResumeListReactor: Reactor {
  enum Action {
    case loadResume
  }
  
  enum Mutation {
    case setResume(Resume)
    case setUserInfo(User)
  }
  
  struct State {
    var data = [ResumeListData]()
    var resume: Resume?
    var userInfo: User?
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
    case .loadResume:
      return self.loadResume()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setResume(let resume):
      newState.resume = resume
      newState.data = self.createDataSource(resume: resume, userInfo: newState.userInfo)
    case .setUserInfo(let userInfo):
      newState.userInfo = userInfo
      newState.data = self.createDataSource(resume: newState.resume, userInfo: userInfo)
    }
    
    return newState
  }
  
  private func loadResume() -> Observable<Mutation> {
    let resume = self.userService.loadResume()
      .map(Mutation.setResume)
    
    let userInfo = self.userService.loadMyInfo()
      .map(Mutation.setUserInfo)
    
    return .merge(resume, userInfo)
  }
  
  private func createDataSource(resume: Resume?, userInfo: User?) -> [ResumeListData] {
    var data = [ResumeListData]()
    
    guard let resume = resume,
          let userInfo = userInfo
    else {
      return []
    }
    
    let career = resume.career.map { ResumeListItem.defaultItem($0) }
    data.append(
      ResumeListData(
        type: .career,
        items: career + [.addItem]
      )
    )
    
    let certification = resume.certificate.map { ResumeListItem.defaultItem($0) }
    data.append(
      ResumeListData(
        type: .certification,
        items: certification + [.addItem]
      )
    )
    
    let school = resume.academic.map {
      ResumeListItem.defaultItem($0)
    }
    data.append(
      ResumeListData(
        type: .school,
        items: school + [.addItem]
      )
    )
    
    data.append(ResumeListData(type: .military, items: [.defaultItem(resume.military)]))
    
    if let address = userInfo.address {
      data.append(ResumeListData(type: .address, items: [.multilineItem(address)]))
    } else {
      data.append(ResumeListData(type: .address, items: [.addItem]))
    }
    
    if let introduce = userInfo.introduce {
      data.append(ResumeListData(type: .introduction, items: [.multilineItem(introduce)]))
    } else {
      data.append(ResumeListData(type: .address, items: [.addItem]))
    }
    
    return data
  }
}
