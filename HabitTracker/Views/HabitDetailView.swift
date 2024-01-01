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
                        habit.log.insert(newEntry, at: 0)
                        note = ""
                        for i in habit.log {
                            print(i.note + " ", terminator: " ")
                        }
                        print()
                    }
                    .buttonStyle(.bordered)
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
                    
                    ForEach(habit.log, id: \.self){ entry in
                        Text(entry.note)
                    }
                }
                .padding()
            }
            .onAppear(perform: sortLog)
            .navigationTitle(habit.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func sortLog(){
        habit.log.sort { entry1, entry2 in
            entry1.date > entry2.date
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
