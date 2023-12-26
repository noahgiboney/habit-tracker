//
//  Habit.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import Foundation
import Observation

enum HabitTypes: String, CaseIterable, Codable{
    case Productive, Bad
}

@Observable
class Habit: Identifiable, Hashable, Codable{
    
    let id: UUID
    var name: String
    var count: Int
    var description: String
    var type: HabitTypes
    
    init(name: String,description: String, type: HabitTypes) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.type = type
        self.count = 0
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
        hasher.combine(type)
    }
}
