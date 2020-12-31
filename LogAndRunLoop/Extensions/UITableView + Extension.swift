//
//  public extension + UITableView.swift
//  comic
//
//  Created by Chiao-Te Ni on 2017/12/7.
//  Copyright © 2017年 Appimc. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    @discardableResult
    func register<T: UITableViewCell>(cellType: T.Type) -> Self {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
        return self
    }
    
    @discardableResult
    func register<T: UITableViewCell>(cellTypes: [T.Type]) -> Self {
        cellTypes.forEach { register(cellType: $0) }
        return self
    }
    
    @discardableResult
    func register<T: UITableViewHeaderFooterView>(viewType: T.Type) -> Self {
        let className = viewType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
        return self
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
    }
    
    // 可能大量快速呼叫, 不想多判一個boolean, 直接與上面分開func
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.className) as? T
    }
    
    func getCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(with: type, for: indexPath) ?? T()
    }
    
//    func getCell<T: UITableViewCell>(with type: T.Type) -> T {
//        return dequeueReusableCell(with: type) ?? T()
//    }
    
    func dequeueReusableView<T: UIView>(with type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T
    }
}
