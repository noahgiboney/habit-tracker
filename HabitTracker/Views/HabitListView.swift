//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/30/23.
//
import SwiftData
import SwiftUI

struct HabitListView: View {
    
    @Environment(\.modelContext) var context
    
    @Query var habits: [Habit]
    
    var body: some View {
        ForEach(habits) { habit in
            NavigationLink {
                HabitDetailView(habit: habit)
            }label: {
                VStack(alignment: .leading){
                    
                    Spacer()
                    
                    Text(habit.name)
                        .foregroundStyle(habit.type == "Productive" ? .green : .red)
                        .font(.title2)
                    
                    Spacer()
                    
                    Text("Since \(habit.dateAdded.monthDate)")
                        .font(.caption)
                }
            }
        }
        .onDelete(perform: { indexSet in
            deleteHabit(offset: indexSet)
        })
    }
    
    func deleteHabit(offset: IndexSet){
        for i in offset{
            let habit = habits[i]
            context.delete(habit)
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
        }, sort: sortOrder)
    }
}

#Preview {
    HabitListView(filter: "Productive", sortOrder: [SortDescriptor(\Habit.name)])
        .modelContainer(for: Habit.self)
}
