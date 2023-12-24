//
//  Habit.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import Foundation
import Observation

struct Habit: Identifiable, Hashable{
    
    var id = UUID()
    var name: String
    var count: Int
    var description: String
    
    init(id: UUID = UUID(), name: String, count: Int, description: String) {
        self.id = id
        self.name = name
        self.count = count
        self.description = description
    }
    
    //these functions are required to conform to Hashable protocol
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(count)
        hasher.combine(name)
        hasher.combine(description)
    }
}

@Observable
class Habits{
    var userHabits: [Habit] = []
}
