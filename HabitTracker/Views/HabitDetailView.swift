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
            ScrollView{
                VStack{
                    TextField("Entry Note", text: $note, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add Entry"){
                        let newEntry = Entry(note: note)
                        habit.log.append(newEntry)
                    }
                    .buttonStyle(.bordered)
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
                    
                    Text("\(habit.log.count)")
                }
                .padding()
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
        let testHabit = Habit(name: "Gym", type: "Productive")
//        testHabit.log.append(Entry(note: "Testing a note"))
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
