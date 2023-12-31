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
    
    static let habitTypes = ["Productive", "Destructive"]
    
    var name: String
    var type: String
    var dateAdded: Date
    
    init(name: String, type: String, dateAdded: Date ) {
        self.name = name
        self.type = type
        self.dateAdded = dateAdded
    }
}

