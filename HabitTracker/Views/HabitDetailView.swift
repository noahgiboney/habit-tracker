//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @State private var logDescription = ""
    @FocusState private var textFocused: Bool
    var habits: Habits
    var habit: Habit
    
    var logButtonDisabled: Bool{
        return logDescription.count == 0
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("This is a " + habit.type.rawValue.lowercased() + " habit")
                        .foregroundStyle(habit.type == .Productive ? .green : .red)
                    TextField("Breif Description of entry", text: $logDescription)
                        .padding(.bottom)
                        .focused($textFocused)
                }
                
                Section{
                    HStack{
                        Spacer()
                        Button{
                            textFocused.toggle()
                            withAnimation{
                                habit.logs.insert(Log(date: Date(), description: logDescription), at: 0)
                            }
                            saveData()
                            logDescription = ""
                        }label: {
                            Text("Log Habit")
                            Image(systemName: "plus")
                        }
                        .padding(10)
                        .font(.title2)
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                    .listRowBackground(Color.white.opacity(0))
                }
                .disabled(logButtonDisabled)
                
                Section("total freqency"){
                    Text("\(habit.logs.count)")
                        .font(.headline)
                }
                
                
                Section("Habit Log"){
                    
                    if habit.logs.isEmpty {
                        Text("No logs for this habit yet")
                    }
                    else{
                        ForEach(habit.logs, id: \.date){ log in
                            VStack(alignment: .leading){
                                Text(log.date.formattedDate)
                                    .font(.caption)
                                Text(log.description)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .navigationTitle(habit.name)
        }
    }
    
    func saveData() {
        if let index = habits.userHabits.firstIndex(where: {$0.id == habit.id}) {
            habits.userHabits.remove(at: index) //remove habit based on id
            
            habits.userHabits.insert(habit, at: index) //insert habit to update user defaults
        }
    }
}


#Preview {

    
    HabitDetailView(habits: Habits(), habit: Habit(name: "Gym", type: .Productive))
}
