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
    
    var body: some View {
        
        NavigationStack{
            
            List{
                ForEach(habits) { habit in
                    
                    NavigationLink{
                        HabitDetailView(habit: habit)
                    } label: {
                        Text(habit.name)
                            .foregroundStyle(habit.type == .Productive ? .green : .red)
                    }
                }
                .onDelete(perform: { indexSet in
                    delete(for: indexSet)
                })
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
