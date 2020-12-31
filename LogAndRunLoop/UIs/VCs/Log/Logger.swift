//
//  Logger.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/29.
//

import Foundation

final class Logger {
    
    static let shared: Logger = .init()
    
    private let operationQueue: DispatchQueue = .init(label: "LoggerQueue")
    private var waitingLogs: [String] = []
    
    private var isAppInActivity: Bool = false {
        didSet {
            guard isAppInActivity == false else { return }
            self.handleWaitingLogs()
        }
    }
    
    private init() {
        observeRunLoop()
    }
    
    func log(_ text: String) {
        operationQueue.async { [weak self] in
            guard let self = self else { return }
            if self.isAppInActivity {
                self.waitingLogs.append(text)
            } else {
                self.processLog(text)
            }
        }
    }
}

extension Logger {
    
    private func observeRunLoop() {
        let observer = CFRunLoopObserverCreateWithHandler(
            kCFAllocatorDefault,
            CFRunLoopActivity.allActivities.rawValue,
            true,
            0
        ) { [weak self] observer, activity in
            print("🏵", Thread.current)
            self?.operationQueue.async {
                guard let self = self else { return }
                
                switch activity {
                case .afterWaiting, .beforeSources:
                    self.isAppInActivity = true
                case .beforeWaiting:
                    self.isAppInActivity = RunLoop.main.currentMode == .tracking
                default:
                    break
                }
            }
        }
        
        DispatchQueue.global().async {
            CFRunLoopAddObserver(
                CFRunLoopGetMain(),
                observer,
                CFRunLoopMode.commonModes
            )
        }
    }
    
    private func handleWaitingLogs() {
        operationQueue.async { [weak self] in
            let waitingLogs = self?.waitingLogs.compactMap({ log -> String? in
                if self?.isAppInActivity == true {
                    return log
                } else {
                    self?.processLog(log)
                    return nil
                }
            })
            self?.waitingLogs = waitingLogs ?? []
        }
    }
    
    private func processLog(_ log: String) {
        saveLogToDB(log)
        sendLogToServer(log) { result in
            switch result {
            case .success(let log):
                self.removeLogFromDB(log)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveLogToDB(_ log: String) {
        print(log, isAppInActivity)
    }
    
    private func sendLogToServer(_ log: String, then handler: @escaping (Result<String, Error>)->Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            handler(.success(log))
        }
    }
    
    private func removeLogFromDB(_ log: String) {
        //...
    }
}
