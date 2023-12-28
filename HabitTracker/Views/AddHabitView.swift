//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    var habits: Habits
    
    @State private var habitName = ""
    @State private var habitType: HabitTypes = .Productive
    
    var addButtonDisabled: Bool{
        return habitName.count == 0
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
            }
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .confirmationAction) {
                    
                    Button("Done"){
                        habits.userHabits.insert(Habit(name: habitName, type: habitType), at: 0)
                        dismiss()
                    }
                    .disabled(addButtonDisabled)
                    .toolBar()
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                    .toolBar(foreground: .red)
                    
                }
            }
        }
    }
}

#Preview {
    AddHabitView(habits: Habits())
}
