//
//  ScriptView.swift
//  VideoPrompter
//
//  Created by femi alaka on 27/03/2022.
//

import SwiftUI

struct ScriptView: View {

    @Binding var shouldScroll: Bool
    @Binding var scrollOffset: Double
    
    var body: some View {
    
        ScrollView {
            ZStack {
                Text(Teleprompter(fileName: "data", fileType: "txt").document.content)
                    .font(.largeTitle)
                    .transformEffect(CGAffineTransform(translationX: 0, y: scrollOffset))
                    .animation(Animation.linear(duration: shouldScroll ? 60 : 0), value: shouldScroll)
            }
            .offset(y:300)
            .padding()
        }
    }
}

//struct ArmView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScriptView(rotateArm: .constant(true), document: document)
//    }
//}
