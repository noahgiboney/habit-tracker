//
//  Extensions.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/25/23.
//

import Foundation

extension Date{
    var monthDate: String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
    
    var monthDateTime: String{
        self.formatted(date: .abbreviated, time: .shortened)
    }
}
