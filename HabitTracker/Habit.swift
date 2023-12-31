//
//  Habit.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//

import Foundation
import SwiftData

@Model
class Habit {
    
    var name: String
    var type: HabitType
    var dateAdded: Date
    
    init(name: String, type: HabitType, dateAdded: Date ) {
        self.name = name
        self.type = type
        self.dateAdded = dateAdded
    }
}

enum HabitType: String, CaseIterable, Codable {
    case Productive, Destructive
}
