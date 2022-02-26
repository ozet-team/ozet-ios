//
//  ResumeResponse.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/19.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import SwiftDate

struct Resume: Codable {
  let id: Int
  let career: [Career]
  let certificate: [Certificate]
  let academic: [Academic]
  let military: Military
}

struct Career: Codable, ResumeDefaultItem {
  let id: Int
  let company: String
  let position: String
  let joinAt: String
  let quitAt: String?
  let workedOn: String
  
  var title: String? {
    self.company
  }
  
  var date: String? {
    if let quitAt = self.quitAt {
      return "\(self.joinAt) ~ \(quitAt)"
    } else {
      return self.joinAt
    }
  }
}

struct Certificate: Codable, ResumeDefaultItem {
  let id: Int
  let name: String
  let vendor: String
  let certificateAt: String
  
  var title: String? {
    self.name
  }
  
  var date: String? {
    self.certificateAt
  }
}

struct Academic: Codable, ResumeDefaultItem {
  let id: Int
  let name: String?
  let major: String
  let location: String
  let joinAt: String
  let quitAt: String?
  
  var title: String? {
    self.name
  }
  
  var date: String? {
    if let quitAt = self.quitAt {
      return "\(self.joinAt) ~ \(quitAt)"
    } else {
      return self.joinAt
    }
  }
}

enum MilitaryServiceType: String, Codable {
  case NA = "NA"
  case exemption = "EXEMPTION"
  case unfinished = "UNFINISHED"
  case finished = "FINISHED"
  
  var title: String {
    switch self {
    case .NA:
      return "해당없음"
    case .exemption:
      return "면제"
    case .unfinished:
      return "미필"
    case .finished:
      return "군필"
    }
  }
}

struct Military: Codable, ResumeDefaultItem {
  let id: Int
  let service: MilitaryServiceType
  let exemptionReason: String?
  let joinAt: String?
  let quitAt: String?
  
  var title: String? {
    self.service.title
  }
  
  var date: String? {
    switch service {
    case .NA:
      return nil
    case .exemption:
      return self.exemptionReason
    case .unfinished:
      return nil
    case .finished:
      if let joinAt = self.joinAt,
         let quitAt = self.quitAt {
        return "\(joinAt) ~ \(quitAt)"
      } else {
        return self.joinAt
      }
    }
  }
}
