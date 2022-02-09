//
//  UserAPI.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import Moya

enum UserAPI: TargetType {
  case authSMS(phone: String, code: String)
  case sendSMS(phone: String)
  case updateName(name: String)

  var path: String {
    switch self {
    case .sendSMS:
      return "member/auth/passcode/request"

    case .authSMS:
      return "member/auth/passcode/"
      
    case .updateName:
      return "member/user/me/"
    }
  }

  var method: Moya.Method {
    switch self {
    case .sendSMS:
      return .post

    case .authSMS:
      return .post
      
    case .updateName:
      return .patch
    }
  }

  var task: Task {
    switch self {
    case .sendSMS(let phone):
      return .requestParameters(
        parameters: ["phoneNumber": phone],
        encoding: JSONEncoding.default
      )

    case .authSMS(let phone, let code):
      return .requestParameters(
        parameters: [
          "phoneNumber": phone,
          "passcode": code
        ],
        encoding: JSONEncoding.default
      )
      
    case .updateName(let name):
      return .requestParameters(
        parameters: ["name": name],
        encoding: JSONEncoding.default
      )
    }
  }
}
