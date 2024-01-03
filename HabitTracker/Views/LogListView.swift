//
//  LogListView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/1/24.
//
import SwiftData
import SwiftUI

struct LogListView: View {
    
    var habit : Habit
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(habit.log, id: \.self) { entry in
                    HStack{
                        Text(entry.note)
                        Spacer()
                        Text(entry.date.monthDateTime)
                            .font(.caption)
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteEntry(at: indexSet)
                })
            }
            .navigationTitle(habit.name + " Entry Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    EditButton()
                }
            }
        }
    }
    
    func deleteEntry(at offset: IndexSet){
        habit.log.remove(atOffsets: offset)
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym", type: "Productive")
        testHabit.log.append(Entry(note: "Testing a ", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        
        return LogListView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
