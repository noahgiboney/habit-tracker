//
//  WeekActivityView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/2/24.
//
import SwiftData
import SwiftUI

struct WeekActivityView: View {
    
    var habit: Habit
    
    let calender = Calendar.current
    let layout : [Int:String] = [
        1 : "S",
        2 : "M",
        3 : "T",
        4 : "W",
        5 : "T",
        6 : "F",
        7 : "S"
    ]
    
    var lastSeven = calcLastSeven()
    
    @State private var weekModel: [Int] = []
    @State private var weekActivity: [Bool] = []
    
    var body: some View {
        VStack(alignment: .center){
            HStack(spacing: 37){
                ForEach(weekModel, id:\.self) { index in
                    Text(layout[index] ?? "?")
                }
            }
            
            HStack(spacing: 31){
                ForEach(Array(weekActivity.enumerated()), id: \.offset) { index, value in
                    Rectangle()
                        .stroke(Color.black)
                        .fill(value ? Color.green : Color.red.opacity(0))
                        .frame(width: 17, height: 17)
                }
            }
        }.onAppear(perform: {
            getWeekModel()
            getWeekActivity()
        })
    }
    
    func getWeekActivity() {
        weekActivity.removeAll()
        let calendar = Calendar.current // Ensure this is configured with the correct time zone

        for day in lastSeven {
            var found = false

            let startOfDay = calendar.startOfDay(for: day)

            for entry in habit.log {
                let entryStartOfDay = calendar.startOfDay(for: entry.date)

                if startOfDay == entryStartOfDay {
                    weekActivity.append(true)
                    found = true // Set the flag to true
                    break
                }
            }
            if !found {
                weekActivity.append(false)
            }
        }

        print(lastSeven)
        print(weekActivity)
    }


    
    
    func getWeekModel() {
        weekModel.removeAll()
        for index in lastSeven {
            let weekdayComponent = calender.component(.weekday, from: index)
            weekModel.append(weekdayComponent)
        }
        print(weekModel)
    }
    
    static func calcLastSeven() -> [Date] {
        var calendar = Calendar.current
        var week = [Date]()
        let now = calendar.startOfDay(for: Date()) // Normalize to the start of the current day

        for index in (0...6) {
            if let previous = calendar.date(byAdding: .day, value: -index, to: now) {
                week.append(previous)
            }
        }
        return week.reversed() // This will return the dates in ascending order from the farthest to the closest to today.
    }}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let testHabit = Habit(name: "Gym", type: "Productive")
        testHabit.log.append(Entry(note: "Testing a ", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        testHabit.log.append(Entry(note: "Testing a note", date: .now))
        
        
        return WeekActivityView(habit: testHabit)
            .modelContainer(container)
        
    }catch{
        return Text("Fail to use swift data")
    }
}
