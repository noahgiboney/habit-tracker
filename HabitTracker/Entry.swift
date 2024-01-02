//
//  Entry.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/31/23.
//
import Foundation


struct Entry : Codable, Hashable{
    var note: String
    var date: Date
}
