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
            Form{
                ForEach(habits.userHabits){ habit in
                    Section{
                        NavigationLink(value: habit, label: {
                            HStack{
                                Text(habit.name)
                                Text("\(habit.count)")
                            }
                        })
                        .padding()
                    }
                }
                .onDelete(perform:{ indexSet in
                    delete(at: indexSet)
                })

            }
            .navigationTitle("Habit Tracker")
            .navigationDestination(for: Habit.self){ habit in
                Text("\(habit.id)")
            }
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
        }.sheet(isPresented: $addHabit, content: {
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
