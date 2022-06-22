//
//  ScrollModifier.swift
//  VideoPrompter
//
//  Created by femi alaka on 30/03/2022.
//

import Foundation
import SwiftUI

struct ScrollModifier: AnimatableModifier {
    
    var scrollOffset: CGFloat
    var maxScrollOffset: CGFloat
    var timeDuration: Double
    var speedUp: CGFloat
    
    @Binding var percentage: CGFloat
    @Binding var isScrolling: Bool
    
    private var percentValue: CGFloat // Percentage of maximum count
    
    init(
        maxScrollOffset: CGFloat,
        scrollOffset: CGFloat,
        timeDuration: Double,
        percentage: Binding<CGFloat>,
        isScrolling: Binding<Bool>,
        speedUp: CGFloat
    ) {
        self.scrollOffset = scrollOffset
        self.maxScrollOffset = maxScrollOffset
        self.timeDuration = timeDuration
        self.speedUp = speedUp
        _percentage = percentage // Bindings initialization
        _isScrolling = isScrolling
        // The percent value is copied  from the binding, later on it will be used for the animation
        percentValue = percentage.wrappedValue
        
        //let _ = print("\n\nscrollOffset: \(self.scrollOffset) \n maxScrollOffset \(self.maxScrollOffset) \n timeDuration  \(self.timeDuration) ")
    }
    
    var animatableData: CGFloat {
        get { percentValue }
        set { percentValue = newValue }
    }
    
    var value: Int {
        Int(percentValue * maxScrollOffset)
    }
    
    var timeRemaining: Double {
        timeDuration * Double(1 - percentValue)
    }
    
    var endImg: some View {
        Image("end")
            .resizable()
            .padding(.top, 30)
            .frame(width:150, height:150)
    }
    
    func body(content: Content) -> some View {
        
        ScrollView {
            VStack {
                //Text("\(value, specifier: "%03d")")
                content
            }
            .onChange(of: isScrolling) { _ in
                handleStartStop()
            }
            .offset(x: 0.0, y: scrollOffset + CGFloat(value))
            .animation(.linear(duration: timeDuration).repeatForever(autoreverses: false), value: true)
            .padding()
        }
    }
    
    func handleStart() -> () {
        if isScrolling {
            withAnimation(.linear(duration: timeDuration)) {
                self.percentage = 1
            }
        }
    }
    
    func handleStartStop() -> () { // Formerly handleStart()
        if isScrolling {
            withAnimation(.linear(duration: timeRemaining)) {
                self.percentage = 1
            }
        } else {
            withAnimation(.linear(duration: 0)) {
                self.percentage = percentValue
            }
        }
    }
}

//How do we set the speed of the Offset? is Duration the only option?
