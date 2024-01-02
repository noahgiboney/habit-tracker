//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var note = ""
    @State private var showingConfirmation = false
    @State private var showingDeleteAlert = false
    
    @FocusState private var entryKeyFocused: Bool
    
    var validEntry: Bool {
        note.isEmpty
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        
                        Text("\(habit.type) habit \(habit.type == "Productive" ? "🤩" : "👎")")
                            .padding(.bottom)
                            .font(.headline)
                        
                        TextField("Entry Note", text: $note, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .focused($entryKeyFocused)
                        
                        Button("Add Entry"){
                            let newEntry = Entry(note: note)
                            habit.log.insert(newEntry, at: 0)
                            entryKeyFocused.toggle()
                            note = ""

                        }
                        .disabled(validEntry)
                        .padding(.top)
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("Your Log")
                        .font(.title)
                        .padding(.leading)
                    
                    if habit.log.isEmpty {
                        ContentUnavailableView("No Entrys", systemImage: "pencil")
                    }
                    else{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(habit.log, id: \.self) { entry in
                                    
                                    VStack(alignment: .leading){
                                        Spacer()
                                        Text(entry.note)
                                        Spacer()
                                        Spacer()
                                        Text("\(entry.date.formattedDate)")
                                            .font(.caption)
                                        Spacer()
                                    }
                                    .frame(width: 150, height: 125)
                                    .background(.ultraThinMaterial)
                                    .shadow(radius: 3)
                                }
                                if habit.log.count >= 4 {
                                    NavigationLink("View All"){
                                        LogListView(habit: habit)
                                    }
                                }
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .navigationTitle(habit.name)
            .toolbar{
                ToolbarItem{
                    Button("Edit"){
                        showingConfirmation.toggle()
                    }
                }
            }
            .confirmationDialog("Delete Habit", isPresented: $showingConfirmation) {
                
                NavigationLink(destination: EditHabitView(habit: habit)){
                    Button("Edit Habit"){}
                }
                
                Button("Delete" , role: .destructive) {
                    showingDeleteAlert.toggle()
                }
            }
            .alert("Delete Habit", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive){
                    context.delete(habit)
                    dismiss()
                }
            } message: {
                Text("Are you sure you want to delete \(habit.name) habit?")
            }
        }
    }
}

#Preview {
    
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym", type: "Productive")
//        testHabit.log.append(Entry(note: "Testing a "))
//        testHabit.log.append(Entry(note: "Testing a note"))
//        testHabit.log.append(Entry(note: "Testing a note"))
//        testHabit.log.append(Entry(note: "Testing a note"))
        
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
