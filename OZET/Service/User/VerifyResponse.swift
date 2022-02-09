//
//  VerifyResponse.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/01/28.
//  Copyright © 2022 app.OZET. All rights reserved.
//
import Foundation

import SwiftDate

struct VerifyResponse: Decodable {
  let expireAt: Date?
  
  enum CodingKeys: String, CodingKey {
    case requestedVerify
  }
  
  enum VerifyKeys: String, CodingKey {
    case expireAt
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let verify = try container.nestedContainer(
      keyedBy: VerifyKeys.self,
      forKey: .requestedVerify
    )
    self.expireAt = try verify.decode(String.self, forKey: .expireAt).toISODate()?.date
  }
}
