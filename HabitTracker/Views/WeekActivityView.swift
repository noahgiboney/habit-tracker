//
//  WeekActivityView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/2/24.
//
import SwiftData
import SwiftUI

struct WeekActivityView: View {
    
    @State private var weekModel: [Int] = []
    @State private var weekActivity: [Bool] = []
    
    let layout : [Int:String] = [
        1 : "Sun",
        2 : "Mon",
        3 : "Tue",
        4 : "Wed",
        5 : "Th",
        6 : "Fri",
        7 : "Sat"
    ]
    
    let calendar = Calendar.current
    var lastSeven = calcLastSeven()
    var habit: Habit
    
    var body: some View {
        VStack(alignment: .center){
            HStack(spacing: 20){
                
                ForEach(weekModel, id:\.self) { index in
                    let current = calendar.component(.weekday, from: .now)
                    Text(layout[index] ?? "?")
                        .foregroundStyle(current == index ? Color.purple : Color.black)
                }
            }
            
            HStack(spacing: 30){
        
                ForEach(Array(weekActivity.enumerated()), id: \.offset) { index, value in
                    Rectangle()
                        .stroke(Color.black)
                        .fill(value ? Color.green : Color.red.opacity(0))
                        .frame(width: 17, height: 17)
                }
            }
            .padding(.leading, 20)
        }.onAppear(perform: {
            getWeekModel()
            getWeekActivity()
        })
    }
    
    func getWeekActivity() {
        
        weekActivity.removeAll()
        
        for day in lastSeven {
            
            var found = false
            let startOfDay = calendar.startOfDay(for: day)
            
            for entry in habit.log {
                
                let entryStartOfDay = calendar.startOfDay(for: entry.date)
                
                if startOfDay == entryStartOfDay {
                    weekActivity.append(true)
                    found = true
                    break
                }
            }
            if !found {
                weekActivity.append(false)
            }
        }
    }

    func getWeekModel() {
        
        weekModel.removeAll()
        
        for day in lastSeven {
            let weekdayComponent = calendar.component(.weekday, from: day)
            weekModel.append(weekdayComponent)
        }
    }
    
    static func calcLastSeven() -> [Date] {
        let calendar = Calendar.current
        var week = [Date]()
        let now = calendar.startOfDay(for: Date())

        for index in (0...6) {
            if let previous = calendar.date(byAdding: .day, value: -index, to: now) {
                week.append(previous)
            }
        }
        return week
    }}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym", type: "Productive")
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        
        return WeekActivityView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
