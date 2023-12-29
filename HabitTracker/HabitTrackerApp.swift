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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Habit.self)
    }
}
