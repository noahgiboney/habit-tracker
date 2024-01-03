//
//  WeekActivityView.swift
//  HabitTracker
//
//  Created by Noah Giboney on 1/2/24.
//

import SwiftUI

struct WeekActivityView: View {
    var body: some View {
        VStack(alignment: .center){
            HStack(spacing: 33){
                Text("S")
                Text("M")
                Text("T")
                Text("W")
                Text("T")
                Text("F")
                Text("S")
            }
            
            HStack(spacing: 24){
                ForEach(1..<8) { _ in
                    Rectangle()
                        .stroke(Color.black)
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

#Preview {
    WeekActivityView()
}
