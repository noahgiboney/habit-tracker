//
//  ContentView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var addHabit = false
    var habits = Habits()
    
    var body: some View {
        NavigationStack{
            Form{
                ForEach(habits.userHabits){ habit in
                    Text(habit.name)
                    .padding()
                    
                    Button("Increment"){
                        //increase count for habit here
                    }
                }
            }
            
            .navigationTitle("Habit Tracker")
            .navigationDestination(for: Habit.self){ habit in
                Text("\(habit.id)")
            }
            .toolbar{
                ToolbarItem{
                    Button{
                        addHabit.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }.sheet(isPresented: $addHabit, content: {
            AddHabitView()
        })
    }
}

#Preview {
    ContentView()
}
