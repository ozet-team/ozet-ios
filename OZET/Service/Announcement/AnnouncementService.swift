//
//  AnnouncementService.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/12.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import RxSwift


protocol AnnouncementService: AnyObject {
  func recommendAnnouncement() -> Observable<[Announcement]>
  func recentAnnouncement() -> Observable<[Announcement]>
}

final class AnnouncementServiceImpl: AnnouncementService {
  
  // MARK: Property
  private let provider: AnnouncementProvider
  
  init(provider: AnnouncementProvider) {
    self.provider = provider
  }
  
  func recommendAnnouncement() -> Observable<[Announcement]> {
    self.provider.rx.request(.loadAnnouncements)
      .map(AnnouncementList.self)
      .map(\.results)
      .asObservable()
  }
  
  func recentAnnouncement() -> Observable<[Announcement]> {
    self.provider.rx.request(.loadAnnouncements)
      .map(AnnouncementList.self)
      .map(\.results)
      .asObservable()
  }
}
