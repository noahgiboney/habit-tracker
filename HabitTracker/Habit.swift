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
    var type: String
    var dateAdded = Date()
    var log = [Entry]()
    
    init(name: String, type: String, dateAdded: Date = Date(), log: [Entry] = [Entry]()) {
        self.name = name
        self.type = type
        self.dateAdded = dateAdded
        self.log = log
    }
    
    static let habitTypes = ["Productive", "Destructive"]
    
    static func validTextInput(input: String) -> Bool {
        return input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

