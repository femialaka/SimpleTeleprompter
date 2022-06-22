//
//  Teleprompter.swift
//  VideoPrompter
//
//  Created by femi alaka on 25/03/2022.
//

import Foundation
import SwiftUI
import PDFKit

struct Teleprompter {
    
    private(set)var document: Document
    
    
//    init(fileName: String, createDocumentContent: (String) -> Document) {
//        let document = createDocumentContent(fileName)
//        self.document = document
//    }
    
    
    init(fileName: String, fileType: String) {
        self.document = Document(content: "content")
        let content = self.loadTextFile()
        self.document = Document(content: content)
    }
    
    private func loadTextFile() -> String {
        guard let data = File.appData(from: "data.txt") else {
            return "File dose not exist"
        }
       let string = String(data: data, encoding: .utf8)

       return string ?? "oops! unrecognized format"
    }
    
    struct Document {
        var fileName = "data"
        var fileType = "txt"
        var content: String
        var duration = 200.0
        var from = 0
        var to = 0
    }
    
    enum File {
      static func appData(from file: String, in bundle: Bundle = .main) -> Data? {
        guard let path = bundle.url(forResource: file, withExtension: nil) else {
          return nil
        }

        var data: Data?
        do {
          data = try Data(contentsOf: path)
        }
        catch {
          print("Error reading data: \(error)")
        }

        return data
      }
    }
}
