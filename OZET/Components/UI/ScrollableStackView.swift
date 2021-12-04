//
//  ScrollableStackView.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit

final class ScrollableStackView: BaseScrollView {
  // MARK: UI Components
  private let stackView = UIStackView().then {
    $0.axis = .vertical
  }

  // MARK: Init
  init(spacing: CGFloat) {
    super.init(frame: .zero)
    self.stackView.spacing = spacing
    self.showsVerticalScrollIndicator = false
    self.showsHorizontalScrollIndicator = false
    self.configureSubView()
  }

  required init?(coder: NSCoder) {
    fatalError("")
  }

  // MARK: Layout
  private func configureSubView() {
    self.addSubview(self.stackView)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.stackView.snp.makeConstraints { make in
      make.edges.width.equalToSuperview()
    }
  }

  func addStackView(_ view: [UIView]) {
    view.forEach { [weak self] in
      self?.stackView.addArrangedSubview($0)
    }
  }
}
