//
//  Habits.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/25/23.
//

import Foundation

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
