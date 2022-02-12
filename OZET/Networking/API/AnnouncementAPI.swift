//
//  AnnouncementAPI.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/12.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import Moya

enum AnnouncementAPI: TargetType {
  case loadAnnouncements
  
  var path: String {
    "announcement/announcements/"
  }
  
  var method: Method {
    .get
  }
  
  var task: Task {
    .requestParameters(
      parameters: [
        "limit": 10,
        "offset": 10
      ],
      encoding: URLEncoding.default
    )
  }
}
