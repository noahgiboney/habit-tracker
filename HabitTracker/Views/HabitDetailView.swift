//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct HabitDetailView: View {
    
    @Bindable var habit: Habit
    @State private var note = ""
    
    var body: some View {
        NavigationStack {
            
            ScrollView{
                
                VStack(alignment: .leading){

                    VStack{
                        
                        TextField("Entry Note", text: $note, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                    
                        Button("Add Entry") {
                            let newEntry = Entry(note: note)
                            habit.log.append(newEntry)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.horizontal)
                    
                    Text("Entry Log")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    if habit.log .isEmpty {
                        Text("Log is currently empty. When you do this habit log the entry with a note above to track your activity.")
                    }
                    else{
                     
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(habit.log) { entry in
                                    VStack(alignment: .leading) {
                                        Text(entry.note)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                        Text("\(entry.date.formattedDate)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 200, height: 100)
                                    .padding()
                                    .background(Color.gray.opacity(0.7))
                                    .cornerRadius(12)
                                    .shadow(radius: 10)
                                }
                            }
                        }
                    }
                }
                
            }
            .padding()
            .navigationTitle(habit.name)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym", type: .Productive)
//        testHabit.log.append(Entry(note: "Testing a note"))
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
