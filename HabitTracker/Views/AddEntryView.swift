//
//  AddEntryView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/2/24.
//

import SwiftUI

struct AddEntryView: View {
    
    var habit: Habit
    @Environment(\.dismiss) var dismiss
    @State private var note = ""
    @State private var date = Date()
    @FocusState private var entryKeyFocused: Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Entry Details"){
                    TextField("Entry Note", text: $note, axis: .vertical)
                        .focused($entryKeyFocused)
                    
                    DatePicker("When?", selection: $date, in: ...Date())
                }
                
                Button("Add"){
                    habit.log.insert(Entry(note: note, date: date), at: 0)
                    entryKeyFocused.toggle()
                    note = ""
                    dismiss()
                }
                .disabled(Habit.validTextInput(input: note))
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel", role: .cancel){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddEntryView(habit: Habit(name: "Gym", type: "Productive"))
}
