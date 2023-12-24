//
//  HomeView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var addHabit = false
    var userHabits = [Habit(name: "GYm", count: 0, description: "Going to the gym")]
    
    var body: some View {
        NavigationStack{
            Form{
                ForEach(userHabits){ habit in
                    NavigationLink(value: habit){
                        Text(habit.name)
                    }
                    .padding()
                }
            }
            .navigationTitle("Habit Tracker")
            .navigationDestination(for: Habit.self){ habit in
                Text("\(habit.id)")
            }
            .toolbar{
                ToolbarItem{
                    Button{
                        //show add habit sheet
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
