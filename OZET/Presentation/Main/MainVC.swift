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

  private let resumeGuideButton = UIButton().then {
    $0.setTitle("디자인이 없는 버튼\n비로그인 -> 로그인 화면\n로그인 -> 이력서 화면", for: .normal)
    $0.setTitleColor(.ozet.blackWithDark, for: .normal)
    $0.titleLabel?.textAlignment = .center
    $0.titleLabel?.numberOfLines = 0
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

    self.containerView.addStackView([
      self.resumeGuideButton,
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
      make.top.equalTo(self.titleView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }

    self.resumeGuideButton.snp.makeConstraints { make in
      make.height.equalTo(150)
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
    let vc = ResumeListVC()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  private func presentWebView(type: WebViewType) {
    let vc = WebVC(type: type)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
