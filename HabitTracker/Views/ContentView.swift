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
    
    @State private var sortOrder = [SortDescriptor(\Habit.name)]
    @State private var showingAddSheet = false
    @State private var habitDisplayType = "All"
    
    var body: some View {
        
        NavigationStack{
            
            List{
                Picker("Habit Selection", selection: $habitDisplayType){
                    Text("All")
                }
                
                HabitListView(sortOrder: sortOrder)
                .navigationTitle("Habit Tracker")
                .sheet(isPresented: $showingAddSheet){
                    AddHabitView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus"){
                        showingAddSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem{
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
  
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
    ContentView()
}
