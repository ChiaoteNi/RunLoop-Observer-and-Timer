//
//  CommonTimerCell.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/29.
//

import UIKit

final class CommonTimerCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    private var timer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTimer()
    }
}

extension CommonTimerCell {
    
    private func setupTimer() {
        
        let timer: Timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.titleLabel.text = "\(Date())"
        })
        RunLoop.current.add(timer, forMode: .default)
        timer.fire()
        self.timer = timer
    }
}
