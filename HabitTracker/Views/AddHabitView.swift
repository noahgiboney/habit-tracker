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
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Habit Name", text: $name)
                }
                
                Section{
                    Button("Save"){
                        let newHabit = Habit(name: name)
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
