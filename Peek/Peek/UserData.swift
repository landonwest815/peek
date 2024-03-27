//
//  UserData.swift
//  Peek
//
//  Created by Landon West on 3/18/24.
//

import Foundation
import SwiftData

@Model
final class UserData {
    var categories = ["N/A", "PHYS", "KINES"]
    var taskItems: [TaskItem] = []
    
    init() {
    }
    
    func deleteItem(item: TaskItem) {
        modelContext?.delete(item)
        try? modelContext?.save()
    }
}
