//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = Habit.habitTypes[0]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Habit Name", text: $name)
                
                    Picker("Habit Type", selection: $type){
                        ForEach(Habit.habitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Button("Save", action: saveHabit)
                    .disabled(Habit.validTextInput(input: name))
            }
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
    
    func saveHabit(){
        let newHabit = Habit(name: name, type: type)
        context.insert(newHabit)
        dismiss()
    }
}

#Preview {
    AddHabitView()
}
