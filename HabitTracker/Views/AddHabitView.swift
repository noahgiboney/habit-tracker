//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    var habits = Habits()
    
    @State private var habitName = ""
    @State private var habitDescription = ""
    @State private var habitType: HabitTypes = .Productive
    
    enum HabitTypes: String, CaseIterable{
        case Productive, Bad
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Habit Name", text: $habitName)
                }
                Section{
                    Picker("Habit Type", selection: $habitType){
                        ForEach(HabitTypes.allCases, id: \.self){ type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    TextField("Breif Description", text: $habitDescription)
                }
            }
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done"){
                        habits.userHabits.append(Habit(name: habitName, count: 0, description: habitDescription))
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
}
