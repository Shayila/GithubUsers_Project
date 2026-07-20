//
//  InternetManager.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 18/07/26.
//

import SwiftUI
import Network
import Observation

@Observable
class InternetManager {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    
    var isAvailable = false
    
    
    init() {
        monitor.pathUpdateHandler = {[weak self] path in
            DispatchQueue.main.async {
                
                self?.isAvailable = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
