//
//  MainVC.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/10/09.
//

import UIKit

final class MainVC: BaseVC {

  // MARK: UI Components
  private let titleView = UIView()
  private let infoView = UIView()
  private let containerView = ScrollableStackView(spacing: 30)
  private let firstList = MainRecruitPostListView()
  private let secondList = MainRecruitPostListView()
  private let thirdList = MainRecruitPostListView()

  private let testWebViewButton = UIButton().then {
    $0.setTitle("웹뷰", for: .normal)
    $0.setTitleColor(.ozet.blackWithDark, for: .normal)
  }

  private let resumeButton = UIButton().then {
    $0.setTitle("추가", for: .normal)
    $0.setTitleColor(.ozet.blackWithDark, for: .normal)
  }

  private let listButton = UIButton().then {
    $0.setTitle("이력서", for: .normal)
    $0.setTitleColor(.ozet.blackWithDark, for: .normal)
  }
  
  private let loginButton = UIButton().then {
    $0.setTitle("로그인", for: .normal)
    $0.setTitleColor(.ozet.blackWithDark, for: .normal)
  }

  private let logoView = UIImageView().then {
    $0.image = R.image.splashLogo()
    $0.contentMode = .scaleAspectFit
  }

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubViews()
    self.bind()
  }

  // MARK: Layout
  private func configureSubViews() {
    self.view.addSubview(self.titleView)
    self.view.addSubview(self.containerView)
    self.view.addSubview(self.testWebViewButton)
    self.view.addSubview(self.resumeButton)
    self.view.addSubview(self.listButton)
    self.view.addSubview(self.loginButton)

    self.titleView.addSubview(self.logoView)

    self.containerView.addStackView([
      self.infoView,
      self.firstList,
      self.secondList,
      self.thirdList
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

    self.infoView.snp.makeConstraints { make in
      make.height.equalTo(150)
    }

    self.testWebViewButton.snp.makeConstraints { make in
      make.top.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
      make.width.equalTo(40)
    }

    self.resumeButton.snp.makeConstraints { make in
      make.trailing.equalTo(self.testWebViewButton.snp.leading)
      make.centerY.equalTo(self.testWebViewButton)
    }

    self.listButton.snp.makeConstraints { make in
      make.trailing.equalTo(self.resumeButton.snp.leading)
      make.centerY.equalTo(self.resumeButton)
    }
    
    self.loginButton.snp.makeConstraints { make in
      make.trailing.equalTo(self.listButton.snp.leading)
      make.centerY.equalTo(self.listButton)
    }
  }

  private func bind() {
    self.testWebViewButton.rx.tap
      .bind { [weak self] in
        let webView = WebVC()
        self?.navigationController?.pushViewController(webView, animated: true)
      }
      .disposed(by: self.disposeBag)

    self.listButton.rx.tap
      .bind { [weak self] in
        let vc = ResumeListVC()
        self?.navigationController?.pushViewController(vc, animated: true)
      }
      .disposed(by: self.disposeBag)

    self.resumeButton.rx.tap
      .bind { [weak self] in
        let alert = UIAlertController(
          title: "입력폼",
          message: nil,
          preferredStyle: .actionSheet
        )
        for item in ResumeAddType.allCases {
          alert.addAction(UIAlertAction(
            title: item.title,
            style: .default,
            handler: { action in
              let vc = AddResumeItemVC(type: item)
              self?.navigationController?.pushViewController(vc, animated: true)
            }
          ))
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self?.present(alert, animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
    
    self.loginButton.rx.tap
      .bind { [weak self] _ in
        let reactor = PhoneAuthReactor(
          userService: UserServiceImpl(
            userProvider: UserProvider()
          )
        )
        let vc = PhoneAuthVC(reactor: reactor) {
          
        }
        let navigation = UINavigationController(rootViewController: vc)
        navigation.isNavigationBarHidden = true
        self?.present(navigation, animated: true, completion: nil)
      }
      .disposed(by: self.disposeBag)
  }
}
