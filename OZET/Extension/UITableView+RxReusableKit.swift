//
//  UITableView+RxReusableKit.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/19.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import ReusableKit
import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UITableView {
  public func items<S: Sequence, Cell: UITableViewCell, O: ObservableType>(
    _ reusableCell: ReusableCell<Cell>
  ) -> (_ source: O)
    -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
    -> Disposable
    where O.Element == S {
    return { source in
      return { configureCell in
        return self.items(cellIdentifier: reusableCell.identifier, cellType: Cell.self)(source)(configureCell)
      }
    }
  }
}
