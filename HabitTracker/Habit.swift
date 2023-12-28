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

struct Log: Codable, Hashable {
    var date: Date
    var description: String
}

@Observable
class Habit: Identifiable, Codable{

    let id: UUID
    var name: String
    var logs: [Log]
    var type: HabitTypes
    
    init(name: String, type: HabitTypes) {
        self.name = name
        self.type = type
        self.id = UUID()
        self.logs = []
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
