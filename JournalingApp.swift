//
//  JournalingApp.swift
//  Journaling
//
//  Created on 2025-10-25
//

import SwiftUI

@main
struct JournalingApp: App {
    @StateObject private var journalStore = JournalStore()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(journalStore)
        }
    }
}

