//
//  ScriptModifier.swift
//  VideoPrompter
//
//  Created by femi alaka on 30/03/2022.
//

import Foundation
import SwiftUI

struct ScriptModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        VStack {
            content
        }
        .font(.largeTitle)
        .padding()
    }
}
