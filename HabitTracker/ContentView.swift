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
                        .foregroundColor(habit.type == .Productive ? .green : .red)
                }
                .onDelete(perform: { indexSet in
                    delete(at: indexSet)
                })
            }
            .navigationDestination(for: Habit.self){ habit in
                HabitDetailView(habits: habits, habit: habit)
            }
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .navigationTitle("Habit Tracker")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        addHabit.toggle()
                    }label: {
                        Text("Add")
                    }
                    .toolBar()
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
