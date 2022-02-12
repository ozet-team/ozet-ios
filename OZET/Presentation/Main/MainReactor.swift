//
//  MainReactor.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/12.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import ReactorKit

final class MainReactor: Reactor {
  enum Action {
    case loadAnnouncement
  }
  
  enum Mutation {
    case setRecentAnnouncement([Announcement])
    case setRecommendAnnouncement([Announcement])
  }
  
  struct State {
    var recent = [Announcement]()
    var recommend = [Announcement]()
  }
  
  // MARK: Properties
  var initialState: State = State()
  private let announcementService: AnnouncementService
  
  // MARK: Init
  init(announcementService: AnnouncementService) {
    self.announcementService = announcementService
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    let recommend = self.announcementService.recommendAnnouncement()
      .map { Mutation.setRecommendAnnouncement($0) }
    let recent = self.announcementService.recentAnnouncement()
      .map { Mutation.setRecentAnnouncement($0) }
    
    return .merge(recommend, recent)
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
  
    switch mutation {
    case .setRecentAnnouncement(let result):
      newState.recent = result
      
    case .setRecommendAnnouncement(let result):
      newState.recommend = result
    }
    
    return newState
  }
}
