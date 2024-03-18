//
//  PeekApp.swift
//  Peek
//
//  Created by Landon West on 3/18/24.
//

import SwiftUI
import SwiftData

@main
struct PeekApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            Image(systemName: "pencil.and.outline")
        }
        .menuBarExtraStyle(.window)
    }
}
