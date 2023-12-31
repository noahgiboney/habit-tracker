//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    @State private var note = ""
    
    var body: some View {
        NavigationStack {
            List{
                
            }
            .navigationTitle(habit.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



#Preview {
    
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym", type: .Productive, dateAdded: .now)
//        testHabit.log.append(Entry(note: "Testing a note"))
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
