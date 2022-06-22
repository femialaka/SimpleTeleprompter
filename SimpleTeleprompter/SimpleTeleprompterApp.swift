
//
//  VideoPrompterApp.swift
//  VideoPrompter
//
//  Created by femi alaka on 24/03/2022.
//

import SwiftUI


@main
struct SimpleTeleprompterApp: App {
    let teleprompter = TeleprompterSession()
    var body: some Scene {
        WindowGroup {
            ContentView(teleprompter: teleprompter)
           
        }
    }
}
