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

    var body: some Scene {
        MenuBarExtra {
            ContentView()
                .modelContainer(for: [TaskItem.self, UserData.self])
        } label: {
            Image(systemName: "pencil.and.scribble")
        }
        .menuBarExtraStyle(.window)
    }
}
