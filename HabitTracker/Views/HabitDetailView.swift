//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct HabitDetailView: View {
    
    @Bindable var habit: Habit
    
    var body: some View {
        Text(habit.name)
    }
}

#Preview {
    
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym")
        
        return HabitDetailView(habit: testHabit)
                .modelContainer(container)
    }catch{
        return Text("Failed to user swift data in preview")
    }
}
