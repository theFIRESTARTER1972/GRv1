//
//  Item.swift
//  GRv1
//
//  Created by Darnell Carter on 6/3/25.
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
