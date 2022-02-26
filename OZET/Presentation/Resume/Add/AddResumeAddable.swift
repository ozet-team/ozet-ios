//
//  ResumeAddable.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

enum ResumeType: CaseIterable {
  case career
  case certification
  case school
  case military
  case address
  case introduction

  var title: String? {
    switch self {
    case .career:
      return R.string.ozet.resumeUpdateCareerNavigation()
    case .certification:
      return R.string.ozet.resumeUpdateCertificationNavigation()
    case .school:
      return R.string.ozet.resumeUpdateSchoolNavigation()
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
        .dateRangeField(.careerDuration),
        .selectionField(.careerPosition),
        .multiLineField(.careerProject)
      ]
    case .certification:
      return [
        .defaultField(.certificationName),
        .dateField(.certificateDate),
        .defaultField(.certificationAgency)
      ]
    case .school:
      return [
        .defaultField(.schoolName),
        .defaultField(.schoolSubjectName),
        .dateRangeField(.schoolDuration),
        .defaultField(.schoolLocation)
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
