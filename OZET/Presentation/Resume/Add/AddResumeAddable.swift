//
//  ResumeAddable.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

enum ResumeAddType: CaseIterable {
  case career
  case certification
  case military
  case address
  case introduction

  var title: String? {
    switch self {
    case .career:
      return R.string.ozet.resumeUpdateCareerNavigation()
    case .certification:
      return R.string.ozet.resumeUpdateCertificationNavigation()
    case .military:
      return R.string.ozet.resumeUpdateMilitaryNavigation()
    case .address:
      return R.string.ozet.resumeUpdateAddressNavigation()
    case .introduction:
      return R.string.ozet.resumeUpdateIntroductionNavigation()
    }
  }

  var components: [ResumeAddableType] {
    switch self {
    case .career:
      return [
        .defaultField(.careerShopName),
        .dateField(.certificateDate),
        .selectionField(.careerPosition),
        .multiLineField(.careerProject)
      ]
    case .certification:
      return [
        .defaultField(.certificationName),
        .dateField(.certificateDate),
        .defaultField(.certificationAgency)
      ]
    case.military:
      return [
        .selectionField(.careerPosition),
        .defaultField(.militaryServiceReason)
      ]
    case .address:
      return [
        .defaultField(.address)
      ]
    case .introduction:
      return [
        .multiLineField(.introduction)
      ]
    }
  }

  var path: String {
    "career"
  }

  var requiredKey: [String] {
    []
  }
}
