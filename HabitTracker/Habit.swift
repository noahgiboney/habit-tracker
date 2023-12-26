//
//  Habit.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import Foundation
import Observation

enum HabitTypes: String, CaseIterable, Codable{
    case Productive, Destructive
}

@Observable
class Habit: Identifiable, Hashable, Codable{
    
    let id: UUID
    var name: String
    var counts: [Date]
    var description: String
    var type: HabitTypes
    
    init(name: String,description: String, type: HabitTypes) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.type = type
        self.counts = []
    }
    
    //these functions are required to conform to Hashable protocol
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(counts)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(type)
    }
}

@Observable
class Habits{
    var userHabits: [Habit] {
        didSet{
            if let data = try? JSONEncoder().encode(userHabits){
                UserDefaults.standard.set(data, forKey: "UserHabits")
            }
        }
    }
    
    init(){
        if let savedHabits = UserDefaults.standard.data(forKey: "UserHabits"){
            if let decodedData = try? JSONDecoder().decode([Habit].self, from: savedHabits){
                self.userHabits = decodedData
                return
            }
        }
        userHabits = []
    }
}
