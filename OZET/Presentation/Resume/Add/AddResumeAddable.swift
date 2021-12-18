//
//  ResumeAddable.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

enum ResumeAddType {
  case career

  var title: String? {
    switch self {
    case .career:
      return "경력"
    }
  }

  var components: [ResumeAddableType] {
    switch self {
    case .career:
      return [
        .defaultField(.shopName),
        .dateField(.certificateDate),
        .selectionField(.careerWork),
        .multiLineField(.careerWork)
      ]
    }
  }

  var path: String {
    switch self {
    case .career:
      return "career"
    }
  }

  var requiredKey: [String] {
    switch self {
    case .career:
      return []
    }
  }
}
