//
//  ContentView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var addHabit = false
    @State private var showDeleteHabit = false
    @State private var habits = Habits()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(habits.userHabits){ habit in
                    NavigationLink(habit.name, value: habit)
                        .padding()
                }
                .onDelete(perform: { indexSet in
                    delete(at: indexSet)
                })
            }
            .navigationDestination(for: Habit.self){ habit in
                HabitDetailView(habit: habit)
            }
            .navigationTitle("Habit Tracker")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        addHabit.toggle()
                    }label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $addHabit, content: {
            AddHabitView(habits: habits)
        })
    }
    func delete(at offsets: IndexSet){
        habits.userHabits.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
