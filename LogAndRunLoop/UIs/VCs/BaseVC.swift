//
//  BaseVC.swift
//  SemaphoreDemo
//
//  Created by 倪僑德 on 2020/10/25.
//  Copyright © 2020 倪僑德. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - Private functions
extension BaseVC {
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = .init(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(handleTapClose)
        )
    }
    
    @objc
    private func handleTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
