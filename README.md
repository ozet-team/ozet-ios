OZET
==========

![Swift](https://img.shields.io/badge/Swift-5.5-orange.svg)

[OZET](https://ozet.app) iOS 어플리케이션 소스코드 저장소입니다.

## Environments

- Xcode 13 이상
- Swift 5.5 이상

## Prepare to build

- [Bundler](https://bundler.io)를 이용해 gem 의존성을 관리합니다.
  ```bash
  sudo gem install bundler
  bundle install
  ```
- [Tuist](https://tuist.io/)를 활용해 Xcode 프로젝트를 관리합니다.
  ```bash
  curl -Ls https://install.tuist.io | bash
  ```

- [Cocoapods](https://cocoapods.org)를 이용해 pod 의존성을 관리합니다.

  ```bash
  bundle exec pod install
  tuist generate && bundle exec pod install
  ```

## 코드 컨벤션

- [파일](docs/ozet-style-guide.md) 참고.
