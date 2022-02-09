//
//  PhoneAuthTimerView.swift
//  OZET
//
//  Created by MK-Mac-413 on 2022/02/08.
//  Copyright © 2022 app.OZET. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SwiftDate

extension Reactive where Base: PhoneAuthTimerView {
  var tapRetry: ControlEvent<Void> {
    self.base.retryButton.rx.tap
  }
  
  var startTimer: Binder<Date?> {
    Binder(self.base) { base, date in
      base.startTimer(at: date)
    }
  }
}

final class PhoneAuthTimerView: BaseView {
  // MARK: UI Components
  fileprivate let retryButton = UIButton().then {
    $0.setTitle("재전송", for: .normal)
    $0.setTitleColor(.ozet.gray3, for: .normal)
    $0.titleLabel?.font = .ozet.subtitle1
  }
  
  private let timerLabel = UILabel().then {
    $0.font = .ozet.subtitle1
    $0.textColor = .ozet.gray3
  }
  
  private var timer: Timer?
  
  // MARK: Init
  init() {
    super.init(frame: .zero)
    self.configureSubViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Layout
  private func configureSubViews() {
    self.addSubview(self.retryButton)
    self.addSubview(self.timerLabel)
  }
  
  override func makeConstraints() {
    super.makeConstraints()
    
    self.snp.makeConstraints { make in
      make.height.equalTo(25)
    }
    
    self.retryButton.snp.makeConstraints { make in
      make.leading.top.bottom.equalToSuperview()
    }
    
    self.timerLabel.snp.makeConstraints { make in
      make.trailing.top.bottom.equalToSuperview()
    }
  }
  
  // MARK: Configure
  fileprivate func startTimer(at expired: Date?) {
    guard let expiredAt = expired
    else {
      self.timer?.invalidate()
      self.timer = nil
      self.isHidden = true
      return
    }
    
    self.isHidden = false
    
    self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
      guard let self = self else { return }
      if let leftTime = (expiredAt - Date()).second {
        self.timerLabel.text = "\(leftTime/60):\(leftTime%60)"
        if leftTime <= 0 {
          timer.invalidate()
          self.timer = nil
        }
      }
    }
    
  }
}
