//
//  ContentView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query var habits: [Habit]
    
    @State private var showingAddSheet = false
    
    let typeOptions = ["All", "Productive", "Destructive" ]
    @State private var habitDisplayType = "All"
    @State private var sortOrder = [SortDescriptor(\Habit.dateAdded, order: .reverse)]
    
    var body: some View {
        
        NavigationStack{
            
            List{
                Picker("Displaying", selection: $habitDisplayType){
                    ForEach(typeOptions, id: \.self) { type in
                        Text(type)
                    }
                }
                .font(.headline)
                .padding(.bottom)
                
                HabitListView(filter: habitDisplayType, sortOrder: sortOrder)
            }
            .navigationTitle("Habit Tracker")
            .sheet(isPresented: $showingAddSheet){
                AddHabitView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus"){
                        showingAddSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort Order", selection: $sortOrder){
                            Text("Date Added")
                                .tag([SortDescriptor(\Habit.dateAdded, order: .reverse)])
                            Text("Name")
                                .tag([SortDescriptor(\Habit.name)])
                        }
                    }
                }
            }
        }
    }
    func delete(for offset: IndexSet){
        for i in offset{
            let goneHabit = habits[i]
            context.delete(goneHabit)
        }
    }
}

#Preview {
    
    return ContentView()
}
