//
//  BaseVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import RxViewController

class BaseVC: UIViewController {
  // MARK: Properties
  private(set) var didMakeConstraints = false
  var disposeBag = DisposeBag()

  // MARK: Initializer
  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .ozet.whiteWithDark
    self.view.setNeedsUpdateConstraints()
  }

  // MARK: Layout
  func makeConstraints() {
    // override point
  }

  override func updateViewConstraints() {
    if !self.didMakeConstraints {
      self.makeConstraints()
      self.didMakeConstraints = true
    }

    super.updateViewConstraints()
  }
}
