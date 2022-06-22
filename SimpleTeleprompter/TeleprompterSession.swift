//
//  TeleprompterViewModel.swift
//  VideoPrompter
//
//  Created by femi alaka on 25/03/2022.
//

import Foundation
import SwiftUI
import PDFKit

class TeleprompterSession: ObservableObject {
    
    static func createTeleprompterDocument() -> Teleprompter {
        Teleprompter(fileName: "data", fileType: "pdf")
    }
    
    @Published private var model: Teleprompter = TeleprompterSession.createTeleprompterDocument()
    
    var document: Teleprompter.Document {
        model.document
    }
    
    
}
