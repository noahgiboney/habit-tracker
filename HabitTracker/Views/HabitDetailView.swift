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
                    TextField("Entry Note", text: $note, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add Entry"){
                        let newEntry = Entry(note: note)
                        habit.log.insert(newEntry, at: 0)
                        note = ""
                    }
                    .padding(.vertical)
                    .buttonStyle(.bordered)
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
                    
                    Text("Your Log")
                        .font(.title)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(habit.log, id: \.self){ entry in
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
                            NavigationLink("View All"){
                                
                            }
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
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
        testHabit.log.append(Entry(note: "Testing a "))
        testHabit.log.append(Entry(note: "Testing a note"))
        testHabit.log.append(Entry(note: "Testing a note"))
        
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
