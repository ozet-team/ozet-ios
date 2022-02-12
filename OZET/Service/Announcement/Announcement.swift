//
//  Announcement.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/12.
//  Copyright © 2022 app.OZET. All rights reserved.
//

struct AnnouncementList: Decodable {
  let results: [Announcement]
}

struct Announcement: Decodable {
  let id: Int
  let title: String
  let shopName: String
  let shopLocation: String
}
