//
//  NormalTimerCell.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/29.
//

import UIKit

final class TimerCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    private var timer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTimer()
    }
}

extension TimerCell {
    
    private func setupTimer() {

        timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.titleLabel.text = "\(Date())"
        })
        timer?.fire()
    }
}
