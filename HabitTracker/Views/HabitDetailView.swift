//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    
    var body: some View {
        Text(habit.name)
    }
}

#Preview {
    HabitDetailView(habit: Habit(name: "Gym", count: 0, description: "Working out at the gym"))
}
