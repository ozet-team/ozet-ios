//
//  BottomSheetLayout.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import FloatingPanel

class BottomSheetLayout: FloatingPanelLayout {
  // MARK: Properties
  let halfHeight: CGFloat

  // MARK: Initializer
  init(halfHeight: CGFloat) {
    self.halfHeight = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) + halfHeight
  }

  // MARK: `FloatingPanelLayout` implementaion
  var position: FloatingPanelPosition = .bottom
  var initialState: FloatingPanelState = .half

  var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
    return [
      .half: FloatingPanelLayoutAnchor(
        absoluteInset: self.halfHeight,
        edge: .bottom,
        referenceGuide: .superview
      ),
      .tip: FloatingPanelLayoutAnchor(
        absoluteInset: 0,
        edge: .bottom,
        referenceGuide: .superview
      )
    ]
  }

  func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
    0.4
  }
}
