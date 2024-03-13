//
//  Item.swift
//  SettingsProto
//
//  Created by Jordan Christensen on 3/12/24.
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
