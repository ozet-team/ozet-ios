//
//  DefaultEditableNode.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa
import UIKit

class DefaultEditableNode: BaseNode {

  // MARK: UI Components
  private let titleTextNode: ASTextNode
  private let editableTextNode: ASEditableTextNode

  // MARK: Initializer
  init(title: String, placeholder: String, keyboardType: UIKeyboardType = .default) {
    self.titleTextNode = ASTextNode().then {
      $0.attributedText = title.styled(font: TextStyle.body1, color: .ozet.blackWithDark)
    }
    self.editableTextNode = ASEditableTextNode().then {
      $0.borderColor = UIColor.ozet.blackWithDark.cgColor
      $0.borderWidth = 1
      $0.cornerRadius = 11
      $0.attributedPlaceholderText = placeholder.styled(
        font: TextStyle.body1,
        color: .ozet.blackWithDark
      )
      $0.keyboardType = keyboardType
      $0.textContainerInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
      $0.textView.font = TextStyle.body1
    }
    super.init()
    self.addSubnode(self.titleTextNode)
    self.addSubnode(self.editableTextNode)
  }

  // MARK: Layout
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    self.editableTextNode.style.height = .init(unit: .points, value: 52)
    let stackSpec = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 8,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        self.titleTextNode,
        self.editableTextNode
      ]
    )

    return ASInsetLayoutSpec(
      insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20),
      child: stackSpec
    )
  }
}
