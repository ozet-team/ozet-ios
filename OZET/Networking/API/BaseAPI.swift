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
    return URL()!
  }

  var sampleData: Data {
    return Data()
  }

  var headers: [String: String]? {
    return nil
  }
}

