//
//  ResumeListData.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import RxDataSources

struct ResumeDefaultItem: Equatable {
  let id: Int
  let name: String?
  let date: String?
}

enum ResumeListItem: Equatable, IdentifiableType {
  case defaultItem(ResumeDefaultItem)
  case addItem

  var identity: Int {
    0
  }
}

struct ResumeListData {
  var title: String?
  var items: [Item]
}

extension ResumeListData: AnimatableSectionModelType {
  typealias Identity = String
  typealias Item = ResumeListItem

  var identity: String {
    "resume"
  }

  init(original: ResumeListData, items: [Item]) {
    self = original
    self.items = items.isEmpty ? [.addItem] : items
  }
}

