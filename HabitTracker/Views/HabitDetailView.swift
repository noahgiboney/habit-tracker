//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/29/23.
//
import SwiftData
import SwiftUI

struct HabitDetailView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAddEntrySheet = false
    @State private var showingConfirmation = false
    @State private var showingDeleteAlert = false
    
    var habit: Habit
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    
                    VStack(spacing: 20){
                        Text("\(habit.type) habit \(habit.type == "Productive" ? "👍" : "👎")")
                            .font(.headline)
                        Text("Added \(habit.dateAdded.monthDateTime)")
                            .font(.caption)
                            .padding(.leading)
                    }
                    
                    MyDividor()
                    
                    VStack(alignment: .leading, spacing: 25){
                        Text("Activity")
                            .font(.title)
                        Text("Total Frequency: \(habit.log.count)")
                        Text("Past Week:")
                        WeekActivityView(habit: habit)
                            .padding(.leading)
                    }
                    .padding(.leading)
    
                    MyDividor()
                    
                    VStack(alignment: .leading, spacing: 15){
                        Text("Your Log")
                            .font(.title)
                            .padding(.leading)
                        Button("New Entry"){
                            showingAddEntrySheet.toggle()
                        }
                        .buttonStyle(.bordered)
                        .padding(.leading)
                        
                        if habit.log.isEmpty {
                            ContentUnavailableView("No Entrys", systemImage: "pencil")
                        }
                        else{
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(habit.firstFour(), id: \.self) { entry in
                                        
                                        VStack(alignment: .leading){
                                            Spacer()
                                            Text(entry.note)
                                            Spacer()
                                            Spacer()
                                            Text("\(entry.date.monthDateTime)")
                                                .font(.caption)
                                            Spacer()
                                        }
                                        .frame(width: 150, height: 125)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                    }
                                    if habit.log.count >= 4 {
                                    }
                                }
                                .padding(10)
                            }
                            NavigationLink("View All"){
                                LogListView(habit: habit)
                            }
                            .padding(.leading, 30)
                        }
                    }
                }
            }
            .navigationTitle(habit.name)
            .sheet(isPresented: $showingAddEntrySheet) {
                AddEntryView(habit: habit)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Edit"){
                        showingConfirmation.toggle()
                    }
                }
            }
            .confirmationDialog("Delete Habit", isPresented: $showingConfirmation) {
                
                NavigationLink(destination: EditHabitView(habit: habit)){
                    Button("Edit Habit"){}
                }
                
                Button("Delete Habit" , role: .destructive) {
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
        testHabit.log.append(Entry(note: "Testing a ", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        
        return HabitDetailView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
