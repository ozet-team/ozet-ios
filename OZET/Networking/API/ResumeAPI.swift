//
//  ResumeAPI.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/05.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import Moya

enum ResumeAPI: TargetType {
  case test

  var path: String {
    switch self {
    case .test:
      return ""
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .test:
      return .get
    }
  }

  var task: Task {
    switch self {
    case .test:
      return .requestPlain
    }
  }
}
