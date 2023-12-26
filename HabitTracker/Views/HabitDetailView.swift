//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    var habits: Habits
    var habit: Habit
    
    var body: some View {
        List{
            Section(){
                Text(habit.type.rawValue)
                    .foregroundStyle(habit.type == .Productive ? .blue : .red)
                Text(habit.description)
                    .padding(.vertical)
            }
            
            Section{
                HStack{
                    Spacer()
                    Button{
                        habit.count += 1
                        saveData()
                    }label: {
                        Text("Add Entry")
                        Image(systemName: "plus")
                    }
                    .padding(10)
                    .font(.title2)
                    .buttonStyle(.bordered)
                    Spacer()
                }
                .listRowBackground(Color.white.opacity(0))
            }
            
            Section{
                Text("Freqency: \(habit.count)")
                    .font(.headline)
            }
            
            
            Section("Recent activity"){
                Text("Some entry")
            }
        }
        .navigationTitle(habit.name)
    }
    
    func saveData() {
        if let index = habits.userHabits.firstIndex(where: {$0.id == habit.id}) {
            habits.userHabits.remove(at: index) //remove habit based on id
            
            habits.userHabits.insert(habit, at: index) //insert habit to update user defaults
        }
    }
}


#Preview {

    
    HabitDetailView(habits: Habits(), habit: Habit(name: "Gym", description: "Working Out", type: .Productive))
}
