//
//  ContentView.swift
//  VideoPrompter
//
//  Created by femi alaka on 24/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var teleprompter: TeleprompterSession
    @State var scrollOffset: CGFloat = 300
    @State var totalScrollDistance: CGFloat = -840
    @State var currentScrollDistance: CGFloat = 320
    @State var currentDuration: CGFloat = 12
    @State var percentage = CGFloat(0)
    @State var isPause: Bool = false
    @State var speedUp: CGFloat = 10
    
    var body: some View {
        
        VStack {
            
            GeometryReader { geometry in
                
                VStack {
                    PrompterView(document: teleprompter.document)
                }
                
                .modifier(ScrollModifier(maxScrollOffset: getMaxOffset(height: geometry.size.height + scrollOffset), scrollOffset: scrollOffset, timeDuration: getDuration(height: geometry.size.height + scrollOffset), percentage: $percentage, isScrolling: $isPause, speedUp: speedUp))
            }
        }
        .onDisappear {
            let _ = print(" =============== VIEW HAS GONE =============== ")
        }
        
        controls
    }
    
    private func getMaxOffset(height: CGFloat) -> CGFloat {
        let offsetScale = height * 10
        let _ = print("MaxOffset: \(offsetScale)")
        return -CGFloat(offsetScale)
    }
    
    private func getDuration(height: CGFloat) -> CGFloat {
        let duration = height / 10.0
        let _ = print("DURATION: \(duration)")
        return CGFloat(120)
    }
    
    var reachedEnd: Bool {
        scrollOffset == totalScrollDistance
    }
    
    var isScrolling: Bool {
        scrollOffset > 0 && !reachedEnd
    }
    
    var controls: some View {
        HStack(alignment: .bottom) {
            Button(action: {
                isPause.toggle()
                let _ = print("PLAY: \(isPause)")
            }, label: {
                HStack {
                    if isPause {
                        Text("PAUSE").foregroundColor(Color.blue)
                    }
                    else {
                        Text("PLAY").foregroundColor(Color.red)
                    }
                }
            }
            )
            Button(action: {
                let _ = print("B4 Current Duration: \(currentDuration)")
                currentDuration += CGFloat(20)
                let _ = print("AFTER Current Duration: \(currentDuration)")
            }, label: {
                HStack {
                    Text("FASTER").foregroundColor(Color.blue)
                }
            }
            )
        }.padding()
    }
}

struct PrompterView: View {
    
    let document: Teleprompter.Document
    
    var body: some View {
        Text(document.content)
            .modifier(ScriptModifier())
    }
}
