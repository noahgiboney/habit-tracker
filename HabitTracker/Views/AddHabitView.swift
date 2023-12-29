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
    @State private var type = HabitType.Productive
    
    var body: some View {
        
        NavigationStack{
            
            Form{
                
                Section{
                    
                    TextField("Habit Name", text: $name)
                    
                    Picker("Habit Type", selection: $type){
                        ForEach(HabitType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    
                    Button("Save"){
                        let newHabit = Habit(name: name, type: type)
                        context.insert(newHabit)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
}
