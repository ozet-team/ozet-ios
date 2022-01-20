//
//  AddResumeAddableComponent.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/18.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AddResumeAddableComponent: BaseView {
}

enum ResumeAddableType {
  case defaultField(ResumeDefaultTextFieldType)
  case dateField(ResumeDatePickerTextFieldType)
  case dateRangeField(ResumeDateRangeFieldType)
  case multiLineField(ResumeMultilineFieldType)
  case selectionField(ResumeSelectionFieldType)

  var view: AddResumeAddableComponent {
    switch self {
    case .defaultField(let type):
      return ResumeDefaultTextField(type: type)
    case .dateField(let type):
      return ResumeDatePickerTextField(type: type)
    case .dateRangeField(let type):
      return ResumeDateRangeField(type: type)
    case .multiLineField(let type):
      return ResumeMultilineField(type: type)
    case .selectionField(let type):
      return ResumeSelectionField(type: type)
    }
  }
}
