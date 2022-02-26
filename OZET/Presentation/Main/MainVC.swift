//
//  MainVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit

import ReactorKit

final class MainVC: BaseVC, View {

  // MARK: UI Components
  private let titleView = UIView()
  private let containerView = ScrollableStackView(spacing: 30)
  private let allList = MainRecruitPostListView(type: .all)
  private let recommendList = MainRecruitPostListView(type: .recommend)
  
  private let bannerView = UIView()

  private let resumeGuideButton = UIButton().then {
    $0.setBackgroundImage(R.image.bannerResumeButton(), for: .normal)
  }
  
  private let noticeButton = UIButton().then {
    $0.setBackgroundImage(R.image.bannerNoticeButton(), for: .normal)
  }
  
  private let logoView = UIImageView().then {
    $0.image = R.image.splashLogo()
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: Init
  init(reactor: MainReactor) {
    super.init()
    
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.titleView)
    self.view.addSubview(self.containerView)
    self.titleView.addSubview(self.logoView)
    
    self.bannerView.addSubview(self.resumeGuideButton)
    self.bannerView.addSubview(self.noticeButton)

    self.containerView.addStackView([
      self.bannerView,
      self.allList,
      self.recommendList
    ])
  }

  override func makeConstraints() {
    super.makeConstraints()

    self.titleView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.height.equalTo(44)
    }

    self.logoView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(5)
      make.width.equalTo(60)
    }

    self.containerView.snp.makeConstraints { make in
      make.top.equalTo(self.titleView.snp.bottom).offset(20)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    self.resumeGuideButton.snp.makeConstraints { make in
      make.height.equalTo(self.view.snp.width).multipliedBy(0.55)
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    self.noticeButton.snp.makeConstraints { make in
      make.height.equalTo(self.view.snp.width).multipliedBy(0.26)
      make.top.equalTo(self.resumeGuideButton.snp.bottom).offset(20)
      make.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }

  func bind(reactor: MainReactor) {
    self.input(reactor: reactor)
    self.output(reactor: reactor)
  }
  
  private func input(reactor: MainReactor) {
    self.rx.viewDidLoad
      .map { .loadAnnouncement }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.resumeGuideButton.rx.tap
      .withUnretained(self)
      .bind { (self, _) in
        self.presentResume()
      }
      .disposed(by: self.disposeBag)
    
    self.noticeButton.rx.tap
      .withUnretained(self)
      .bind { (self, _) in
        self.presentNotice()
      }
      .disposed(by: self.disposeBag)
    
    self.allList.rx.tapMore
      .withUnretained(self)
      .bind { (self, _) in
        self.presentWebView(type: .all)
      }
      .disposed(by: self.disposeBag)
    
    self.recommendList.rx.tapMore
      .withUnretained(self)
      .bind { (self, _) in
        self.presentWebView(type: .recommend)
      }
      .disposed(by: self.disposeBag)
    
    self.allList.rx.tapItem
      .withLatestFrom(reactor.state.map(\.recent)) { recent, items in
        items[recent.item]
      }
      .withUnretained(self)
      .bind { (self, item) in
        self.presentWebView(type: .detail(id: item.id))
      }
      .disposed(by: self.disposeBag)
    
    self.recommendList.rx.tapItem
      .withLatestFrom(reactor.state.map(\.recent)) { recent, items in
        items[recent.item]
      }
      .withUnretained(self)
      .bind { (self, item) in
        self.presentWebView(type: .detail(id: item.id))
      }
      .disposed(by: self.disposeBag)
  }
  
  private func output(reactor: MainReactor) {
    reactor.state.map(\.recommend)
      .bind(to: self.recommendList.rx.items)
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.recent)
      .bind(to: self.allList.rx.items)
      .disposed(by: self.disposeBag)
  }
  
  private func presentLogin() {
    let reactor = PhoneAuthReactor(
      userService: UserServiceImpl(
        userProvider: UserProvider()
      )
    )
    let vc = PhoneAuthVC(reactor: reactor) {
      self.presentResume()
    }
    let navigation = UINavigationController(rootViewController: vc)
    navigation.isNavigationBarHidden = true
    self.present(navigation, animated: true, completion: nil)
  }
  
  private func presentResume() {
    guard let _ = UserDefaults.standard.string(forKey: "token")
    else {
      self.presentLogin()
      return
    }
    let reactor = ResumeListReactor(
      userService: UserServiceImpl(
        userProvider: UserProvider()
      )
    )
    let vc = ResumeListVC(reactor: reactor)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  private func presentNotice() {
    let vc = IntroduceVC()
    vc.modalPresentationStyle = .fullScreen
    vc.dismissHandler = { [weak self] in
      self?.presentResume()
    }
    self.present(vc, animated: true, completion: nil)
  }
  
  private func presentWebView(type: WebViewType) {
    let vc = WebVC(type: type)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
