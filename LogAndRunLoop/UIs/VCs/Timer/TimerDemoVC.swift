//
//  TimerDemoVC.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/29.
//

import UIKit

final class TimerDemoVC: BaseVC {
    
    @IBOutlet private var normalTimmerTableView: UITableView!
    @IBOutlet private var runloopTimmerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        observeRunLoopMode()
    }
}

extension TimerDemoVC {
    
    private func setupUI() {
        normalTimmerTableView.register(cellType: TimerCell.self)
        normalTimmerTableView.delegate = self
        normalTimmerTableView.dataSource = self
        
        runloopTimmerTableView.register(cellType: CommonTimerCell.self)
        runloopTimmerTableView.delegate = self
        runloopTimmerTableView.dataSource = self
    }
    
    private func observeRunLoopMode() {
        let observer = CFRunLoopObserverCreateWithHandler(
            kCFAllocatorDefault,
            CFRunLoopActivity.allActivities.rawValue,
            true,
            0
        ) { observer, activity in
            switch activity {
            case .entry:
                print("🧠\(Date()), \(RunLoop.current.currentMode.debugDescription) entry")
            case .exit:
                print("🚼\(Date()), \(RunLoop.current.currentMode.debugDescription) exit")
            default:
                break
            }
        }
        
        CFRunLoopAddObserver(
            CFRunLoopGetMain(),
            observer,
            CFRunLoopMode.commonModes
        )
    }
}

extension TimerDemoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case normalTimmerTableView:
            guard let cell = tableView.dequeueReusableCell(with: TimerCell.self) else { return TimerCell()}
            return cell
        case runloopTimmerTableView:
            guard let cell = tableView.dequeueReusableCell(with: CommonTimerCell.self) else { return CommonTimerCell()}
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(with: TimerCell.self) else { return TimerCell()}
            return cell
        }
    }
}

extension TimerDemoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
