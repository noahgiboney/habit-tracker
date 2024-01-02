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
    @FocusState private var entryKeyFocused: Bool
    
    var validEntry: Bool {
        note.isEmpty
    }
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Entry Note", text: $note, axis: .vertical)
                    .focused($entryKeyFocused)
                
                Button("Add"){
                    habit.log.insert(Entry(note: note), at: 0)
                    entryKeyFocused.toggle()
                    note = ""
                    dismiss()
                }
                .disabled(validEntry)
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
