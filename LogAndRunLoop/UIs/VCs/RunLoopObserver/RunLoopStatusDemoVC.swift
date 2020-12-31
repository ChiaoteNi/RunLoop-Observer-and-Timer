//
//  RunLoopStatusDemoVC.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/27.
//

import UIKit

final class RunLoopStatusDemoVC: BaseVC {
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        observeRunLoop()
    }
}

extension RunLoopStatusDemoVC {
    
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
        
//        dosomething()
    }
    
    private func dosomething() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dosomething()
        }
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

extension RunLoopStatusDemoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(with: SimpleTVCell.self) else { return SimpleTVCell() }
        cell.configureCell(title: "\(indexPath.row)")
        return cell
    }
}

extension RunLoopStatusDemoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
