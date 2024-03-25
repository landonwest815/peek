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

enum TaskColor: String, Codable {
    case red = "eac4d5"
    case green = "b8e0d2"
    case blue = "809bce"
    case purple = "8c80ce"
    case noColor = "n/a"
}

@Model
final class TaskItem: Identifiable {
    var id = UUID()
    var taskName: String
    var weekDay: Weekday
    var importance: ImportanceLevel
    var category: String
    var completed: Bool = false
    var taskColor: TaskColor
    
    init(taskName: String, weekDay: Weekday, importance: ImportanceLevel, category: String, taskColor: TaskColor = .noColor) {
        self.taskName = taskName
        self.weekDay = weekDay
        self.importance = importance
        self.category = category
        self.taskColor = taskColor
    }
}
