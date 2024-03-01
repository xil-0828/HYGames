//
//  Item.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/01.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
