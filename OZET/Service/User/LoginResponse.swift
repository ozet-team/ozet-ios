//
//  LoginResponse.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/01/28.
//  Copyright © 2022 app.OZET. All rights reserved.
//

struct LoginResponse: Decodable {
  let user: User
  let token: String?
}

struct User: Decodable {
  let username: String
  let name: String?
  let email: String?
  let phoneNumber: String
}
