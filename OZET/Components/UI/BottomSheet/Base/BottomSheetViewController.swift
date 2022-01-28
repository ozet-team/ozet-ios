//
//  BottomSheetViewController.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import FloatingPanel

protocol BottomSheetProtocol {
  var halfContentHeight: CGFloat { get }
  var trackedScrollView: UIScrollView? { get }
}

typealias BottomSheetContentViewController = BaseVC & BottomSheetProtocol

class BottomSheetViewController: FloatingPanelController {
  let contentView: BottomSheetContentViewController

  // MARK: Initializer
  init(contentViewController: BottomSheetContentViewController) {
    self.contentView = contentViewController
    super.init(delegate: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureBottomSheet()
  }

  // MARK: Configuration
  private func configureBottomSheet() {

    self.set(contentViewController: self.contentView)
    self.isRemovalInteractionEnabled = true
    self.backdropView.dismissalTapGestureRecognizer.isEnabled = true
    self.contentMode = .fitToBounds
    self.delegate = self

    if let scrollView = self.contentView.trackedScrollView {
      self.track(scrollView: scrollView)
    }

    let appearance = SurfaceAppearance().then {
      $0.cornerRadius = 12
    }
    self.surfaceView.appearance = appearance
    self.surfaceView.grabberHandleSize = CGSize(width: 34, height: 4)
    self.surfaceView.grabberHandlePadding = 12
    self.surfaceView.grabberHandle.backgroundColor = .ozet.gray3

    self.layout = BottomSheetLayout(halfHeight: self.contentView.halfContentHeight)
  }
}

extension BottomSheetViewController: FloatingPanelControllerDelegate {

  // MARK: `FloatingPanelControllerDelegate` implementaion
  func floatingPanelWillEndDragging(
    _ fpc: FloatingPanelController,
    withVelocity velocity: CGPoint,
    targetState: UnsafeMutablePointer<FloatingPanelState>
  ) {
    if targetState.pointee == .tip {
      fpc.dismiss(animated: true, completion: nil)
    }
  }

  func floatingPanelShouldBeginDragging(_ fpc: FloatingPanelController) -> Bool {
    return fpc.panGestureRecognizer.velocity(in: self.view).y > 0
  }
}
