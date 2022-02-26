//
//  ResumeListData.swift
//  OZET
//
//  Created by MK-Mac-255 on 2022/01/14.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import RxDataSources

protocol ResumeDefaultItem {
  var id: Int { get }
  var title: String? { get }
  var date: String? { get }
}

enum ResumeListItem {
  case defaultItem(ResumeDefaultItem)
  case multilineItem(String)
  case addItem
}

struct ResumeListData {
  var type: ResumeType
  var items: [Item]
}

extension ResumeListData: SectionModelType {
  typealias Item = ResumeListItem

  init(original: ResumeListData, items: [Item]) {
    self = original
    self.items = items
  }
}

