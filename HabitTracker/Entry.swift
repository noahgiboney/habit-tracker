//
//  Entry.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/31/23.
//
import SwiftData
import Foundation

@Model
class Entry {
    var note: String
    var date = Date()
    var owner: Habit?
    
    init(note: String, date: Date = Date(), owner: Habit? = nil) {
        self.note = note
        self.date = date
        self.owner = owner
    }
}
