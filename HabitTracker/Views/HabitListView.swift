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
        }
    }
    
    init(sortOrder: [SortDescriptor<Habit>]){
        _habits = Query(sort: sortOrder, animation: .bouncy)
    }
}

#Preview {
    HabitListView(sortOrder: [SortDescriptor(\Habit.name)])
        .modelContainer(for: Habit.self)
}
