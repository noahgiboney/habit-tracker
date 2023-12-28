//
//  ContentView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var addHabit = false
    @State private var showDeleteHabit = false
    @State private var habits = Habits()
    
    let imageURL = URL(string: "https://practicalpie.com/wp-content/uploads/2019/02/habit.png")
    
    var body: some View {
        NavigationStack{
            
            List{
                
                HStack{
                    Spacer()
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                
                if habits.userHabits.isEmpty {
                    
                    Text("You currently have no saved habits, add a habit by clicking above")
                        .font(.headline)
                }
                else{
                    
                    ForEach(habits.userHabits){ habit in
                        NavigationLink(habit.name){
                            HabitDetailView(habits: habits, habit: habit)
                        }
                        .padding()
                        .foregroundColor(habit.type == .Productive ? .green : .red)
                        
                    }
                    .onDelete(perform: { indexSet in
                        delete(at: indexSet)
                    })
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        addHabit.toggle()
                    }label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $addHabit, content: {
            AddHabitView(habits: habits)
        })
    }
    func delete(at offsets: IndexSet){
        habits.userHabits.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
