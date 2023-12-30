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
    
    init(name: String, type: HabitType) {
        self.name = name
        self.type = type
    }
}

enum HabitType: String, CaseIterable, Codable {
    case Productive, Destructive
}
