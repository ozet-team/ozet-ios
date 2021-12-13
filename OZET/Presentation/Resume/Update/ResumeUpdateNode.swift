//
//  ResumeUpdateNode.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/10.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import AsyncDisplayKit

final class ResumeUpdateNode: BaseNode {

  // MARK: UI Components
  private let scrollNode = ASScrollNode().then {
    $0.automaticallyManagesContentSize = true
  }

  private let firstInputNode = DefaultEditableNode(
    title: R.string.ozet.resumeUpdateCareerShopNameTitle(),
    placeholder: R.string.ozet.resumeUpdateCareerShopNamePlaceHolder()
  )

  private let positionInputNode = DefaultEditableNode(
    title: R.string.ozet.resumeUpdateCareerPositionTitle(),
    placeholder: R.string.ozet.resumeUpdateCareerPositionPlaceHolder()
  )

  // MARK: Initializer
  override init() {
    super.init()
    self.addSubnode(self.scrollNode)
    self.scrollNode.addSubnode(self.firstInputNode)
    self.scrollNode.addSubnode(self.positionInputNode)
  }

  // MARK: Layout
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    self.scrollNode.layoutSpecBlock = { [weak self] (_, _) in
      guard let self = self else { return ASLayoutSpec() }
      return ASStackLayoutSpec(
        direction: .vertical,
        spacing: 30,
        justifyContent: .start,
        alignItems: .stretch,
        children: [
          self.firstInputNode,
          self.positionInputNode
        ]
      )
    }
    return ASStackLayoutSpec(
      direction: .vertical,
      spacing: 0,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        self.scrollNode
      ]
    )
  }
}
