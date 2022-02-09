//
//  BaseAPI.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/05.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import Moya

extension TargetType {
  var baseURL: URL {
    return URL(string: "https://api-staging.ozet.app/api/v1/")!
  }

  var sampleData: Data {
    return Data()
  }

  var headers: [String: String]? {
    if let token = UserDefaults.standard.string(forKey: "token") {
      return ["authorization": "JWT " + token]
    }
    return nil
  }
}

