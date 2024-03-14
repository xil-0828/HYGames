//
//  MonitoringNetworkState.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/15.
//

import Foundation
import Network

class MonitoringNetworkState: ObservableObject {

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    @Published var isConnected = false

    init() {
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
    }
}
