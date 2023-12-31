//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/30/23.
//
import SwiftData
import SwiftUI

struct HabitListView: View {
    
    @Query var habits: [Habit]
    
    var body: some View {
        ForEach(habits) { habit in
            NavigationLink(habit.name) {
                HabitDetailView(habit: habit)
            }
            .foregroundStyle(habit.type == "Productive" ? .green : .orange)
        }
    }
    
    init(filter: String, sortOrder: [SortDescriptor<Habit>]){
        _habits = Query( filter: #Predicate<Habit> { habit in
            if filter == "All" {
                return true
            }
           else if habit.type == filter {
                return true
            }
            else{
                return false
            }
        }
            ,sort: sortOrder, animation: .bouncy)
    }
}

#Preview {
    HabitListView(filter: "Productive", sortOrder: [SortDescriptor(\Habit.name)])
        .modelContainer(for: Habit.self)
}
