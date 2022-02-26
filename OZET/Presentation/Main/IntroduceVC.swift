//
//  IntroduceVC.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/20.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class IntroduceVC: BaseVC {
  
  // MARK: UI Components
  private let closeButton = UIButton().then {
    $0.setImage(R.image.iconClose(), for: .normal)
  }
  
  private let scrollView = UIScrollView()
  
  private let introductionImageView = UIImageView().then {
    $0.image = R.image.bgIntro()
  }
  
  private let bottomButton = BottomButton().then {
    $0.text = "이력서 작성하러가기"
    $0.backgroundColor = .ozet.white
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.ozet.purple.cgColor
  }
  
  var dismissHandler: (() -> Void)?
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor(white: 249/255, alpha: 1)
    self.bottomButton.setTitleColor(.ozet.purple, for: .normal)
    self.configureSubViews()
    self.configureButton()
    self.configureScroll()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.scrollView)
    self.view.addSubview(self.closeButton)
    self.view.addSubview(self.bottomButton)
    self.scrollView.addSubview(self.introductionImageView)
  }
  
  private func configureButton() {
    self.closeButton.rx.tap
      .withUnretained(self)
      .bind { (self, _) in
        self.dismiss(animated: true)
      }
      .disposed(by: self.disposeBag)
    
    self.bottomButton.rx.tap
      .withUnretained(self)
      .bind { (self, _) in
        self.dismiss(animated: true) { [weak self] in
          self?.dismissHandler?()
        }
      }
      .disposed(by: self.disposeBag)
  }
  
  private func configureScroll() {
    self.scrollView.rx.contentOffset
      .debounce(.microseconds(300), scheduler: MainScheduler.asyncInstance)
      .filter { [weak self] contentOffset in
        guard let self = self else { return false }
        let offset = self.scrollView.contentSize.height - self.scrollView.bounds.height
        return contentOffset.y > offset * 0.90
      }
      .withUnretained(self)
      .bind { (self, _) in
        UIView.animate(withDuration: 0.3) {
          self.bottomButton.backgroundColor = .ozet.purple
          self.bottomButton.titleLabel?.textColor = .ozet.white
          self.bottomButton.layer.borderWidth = 0
        }
      }
      .disposed(by: self.disposeBag)
  }
  
  override func makeConstraints() {
    super.makeConstraints()
    
    self.closeButton.snp.makeConstraints { make in
      make.leading.equalTo(self.view.safeAreaLayoutGuide).inset(20)
      make.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
      make.size.equalTo(30)
    }
    
    self.scrollView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(90)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    self.introductionImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(50)
      make.leading.trailing.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(self.view.snp.width).multipliedBy(5.53)
    }
  }
}
