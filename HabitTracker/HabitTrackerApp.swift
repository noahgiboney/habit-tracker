//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/24/23.
//

import SwiftData
import SwiftUI

@main
struct HabitTrackerApp: App {
    
    let container: ModelContainer
    
    init(){
        do{
            container = try ModelContainer(for: Habit.self)
        }catch{
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
