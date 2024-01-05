//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/2/24.
//

import SwiftUI

struct EditHabitView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var habit: Habit
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Change Habit Type", selection: $habit.type){
                        ForEach(Habit.habitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Button("Save"){
                  dismiss()
                }
                .buttonStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle($habit.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditHabitView(habit: Habit(name: "Gym", type: "Productive"))
}
