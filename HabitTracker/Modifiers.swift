//
//  Modifiers.swift
//  HabitTracker
//
//  Created by Noah Giboney on 12/25/23.
//

import Foundation
import SwiftUI

struct ToolBar: ViewModifier{
    
    let foreground: Color
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            
    }
}

extension View{
    func toolBar(foreground: Color = .blue) -> some View{
        modifier(ToolBar(foreground: foreground ))
    }
}
