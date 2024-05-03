//
//  Item.swift
//  Peek
//
//  Created by Landon West on 3/18/24.
//

import Foundation
import SwiftData
import SwiftUI
import UniformTypeIdentifiers

enum Weekday: String, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case none = "n/a"
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
final class TaskItem: Identifiable, Hashable, Codable, Transferable {
    
    enum CodingKeys: CodingKey {
            case id, taskName, weekDay, importance, category, completed, taskColor
        }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .taskItem)
    }
    
    @Attribute(.unique) var id = UUID()
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
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            taskName = try container.decode(String.self, forKey: .taskName)
            weekDay = try container.decode(Weekday.self, forKey: .weekDay)
            importance = try container.decode(ImportanceLevel.self, forKey: .importance)
            category = try container.decode(String.self, forKey: .category)
            completed = try container.decode(Bool.self, forKey: .completed)
            taskColor = try container.decode(TaskColor.self, forKey: .taskColor)
        }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(taskName, forKey: .taskName)
            try container.encode(weekDay, forKey: .weekDay)
            try container.encode(importance, forKey: .importance)
            try container.encode(category, forKey: .category)
            try container.encode(completed, forKey: .completed)
            try container.encode(taskColor, forKey: .taskColor)
        }
}

extension UTType {
    static let taskItem = UTType(exportedAs: "co.landonwest.taskItem")
}

