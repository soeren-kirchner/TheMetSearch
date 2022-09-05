//
//  NetworkMonitorManager.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 05.09.22.
//

import Foundation
import Network

class NetworkMonitorManager: ObservableObject {
    
    @Published var connection: NWPath.Status = .requiresConnection
    private let monitor = NWPathMonitor()
    
    private func updateHandler(path: NWPath) {
        DispatchQueue.main.async {
            self.connection = path.status
        }
    }
    
    func activate() {
        monitor.pathUpdateHandler = updateHandler(path:)
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
}
