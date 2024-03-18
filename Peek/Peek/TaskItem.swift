//
//  Item.swift
//  Peek
//
//  Created by Landon West on 3/18/24.
//

import Foundation
import SwiftData

enum Weekday: String, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
}

enum ImportanceLevel: String, Codable {
    case level0 = ""
    case level1 = "!"
    case level2 = "!!"
}

@Model
final class TaskItem {
    var taskName: String
    var weekDay: Weekday
    var importance: ImportanceLevel
    var category: String
    var completed: Bool = false
    
    init(taskName: String, weekDay: Weekday, importance: ImportanceLevel, category: String) {
        self.taskName = taskName
        self.weekDay = weekDay
        self.importance = importance
        self.category = category
    }
}
