//
//  LogDemoVC.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/29.
//

import UIKit

final class LogDemoVC: BaseVC {
    
    @IBOutlet private var tableView: UITableView!
    
    private var observeInfo: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        observeRunLoop()
    }
}

extension LogDemoVC {
    
    private func setupUI() {
        tableView.register(cellType: SimpleTVCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupScrollToButton()
    }
    
    private func observeRunLoop() {
        let observer = CFRunLoopObserverCreateWithHandler(
            kCFAllocatorDefault,
            CFRunLoopActivity.allActivities.rawValue,
            true,
            0
        ) { observer, activity in
            switch activity {
            case .afterWaiting:
                print("🧩afterWaiting \(Date()), \(RunLoop.current.currentMode)")
            case .beforeSources:
                print("🔅beforeSources")
            case .beforeTimers:
                print("🔅beforeTimers")
            case .beforeWaiting:
                print("🔮beforeWaiting \(Date()), \(RunLoop.current.currentMode)")
            case .entry:
                print("🧠\(Date()), \(RunLoop.current.currentMode) entry")
            case .exit:
                print("🚼\(Date()), \(RunLoop.current.currentMode) exit")
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
    
    private func setupScrollToButton() {
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(handleTapScrollTo)
        )
    }
    
    @objc
    private func handleTapScrollTo() {
        tableView.scrollToRow(at: .init(row: 4999, section: 0), at: .bottom, animated: true)
    }
}

extension LogDemoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(with: SimpleTVCell.self) else { return SimpleTVCell() }
        cell.configureCell(title: "\(indexPath.row)")
        return cell
    }
}

extension LogDemoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        Logger.shared.log("滑到了ROW \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Logger.shared.log("點擊了ROW \(indexPath.row)")
    }
}
