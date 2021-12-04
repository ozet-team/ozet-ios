//
//  MyInfoVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/11/28.
//

import UIKit

final class MyInfoVC: BaseVC {

  // MARK: UI Components
  private let bottomButton = BottomButton().then {
    $0.text = R.string.ozet.commonDone()
  }

  private let nameTextField = GuideTextField(
    title: R.string.ozet.nameTextFieldTitle(),
    placeholder: R.string.ozet.nameTextFieldPlaceholder(),
    type: .default
  )

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()

    self.bottomButton.rx.tap
      .bind { [weak self] in
        let vc = MainVC()
        vc.modalPresentationStyle = .fullScreen
        self?.present(vc, animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.nameTextField)
    self.view.addSubview(self.bottomButton)
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.nameTextField.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(100)
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }
}
