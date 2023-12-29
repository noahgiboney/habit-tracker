//
//  Entry.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/28/23.
//

import Foundation

struct Entry: Codable, Hashable {
    var date: Date
    var description: String
}
