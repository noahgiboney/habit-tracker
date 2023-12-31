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
    @State private var habitDisplayType = "All"
    @State private var sortOrder = [SortDescriptor(\Habit.dateAdded, order: .reverse)]
    
    let typeOptions = ["All", "Productive", "Destructive" ]
    
    var body: some View {
        NavigationStack{
            List{
                if habits.isEmpty {
                    ContentUnavailableView("No Habits", systemImage: "book", description: Text("You don't have any habits yet"))
                }
                else{
                    Picker("Displaying", selection: $habitDisplayType){
                        ForEach(typeOptions, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .font(.headline)
                    
                    HabitListView(filter: habitDisplayType, sortOrder: sortOrder)
                }
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
}

#Preview {
    return ContentView()
}
