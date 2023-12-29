//
//  Entry.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/28/23.
//

import Foundation
import SwiftData

@Model
class Entry {
    var date: Date
    var note: String
    
    init(note: String) {
        self.date = Date.now
        self.note = note
    }
}
