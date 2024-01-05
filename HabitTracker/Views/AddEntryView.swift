//
//  AddEntryView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/2/24.
//
import SwiftUI

struct AddEntryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var entryKeyFocused: Bool
    
    @State private var note = ""
    @State private var date = Date()
    
    var habit: Habit
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Entry Details"){
                    TextField("Entry Note", text: $note, axis: .vertical)
                        .focused($entryKeyFocused)
                    
                    DatePicker("When?", selection: $date, in: ...Date())
                }
                
                Button("Add", action: addEntry)
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
    
    func addEntry() {
        habit.log.insert(Entry(note: note, date: date), at: 0)
        entryKeyFocused.toggle()
        note = ""
        dismiss()
    }
}

#Preview {
    AddEntryView(habit: Habit(name: "Gym", type: "Productive"))
}
