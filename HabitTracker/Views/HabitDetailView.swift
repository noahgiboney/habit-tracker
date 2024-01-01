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
                VStack(alignment: .leading){
                    VStack{
                        TextField("Entry Note", text: $note, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Entry"){
                            let newEntry = Entry(note: note)
                            habit.log.insert(newEntry, at: 0)
                            note = ""
                        }
                        .padding(.top)
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding()
                    
                    Text("Your Log")
                        .font(.title)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(habit.log, id: \.self) { entry in
                                
                                VStack(alignment: .leading){
                                    Spacer()
                                    Text(entry.note)
                                    Spacer()
                                    Spacer()
                                    Text("\(entry.date.formattedDate)")
                                        .font(.caption)
                                    Spacer()
                                }
                                .frame(width: 150, height: 125)
                                .background(.ultraThinMaterial)
                                .shadow(radius: 3)
                            }
                            if habit.log.count >= 4 {
                                NavigationLink("View All"){
                                    LogListView(habit: habit)
                                }
                            }
                        }
                        .frame(width: .infinity)
                    }
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding()
                }
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
        testHabit.log.append(Entry(note: "Testing a "))
        testHabit.log.append(Entry(note: "Testing a note"))
        testHabit.log.append(Entry(note: "Testing a note"))
        testHabit.log.append(Entry(note: "Testing a note"))
        
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
