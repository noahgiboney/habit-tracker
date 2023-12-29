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
    
    init(name: String) {
        self.name = name
    }
}

enum HabitType: String, CaseIterable {
    case Productive, Destructive
}
