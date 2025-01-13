//
//  ContentView.swift
//  Peek
//
//  Created by Landon West on 3/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var taskItems: [TaskItem]
    @Query private var userDataArray: [UserData]
    
    // States
    @State private var isOn: Bool = false
    @State private var isOn2: Bool = false
    
    @State private var textEntry: String = ""
    @State private var selected = Weekday.monday
    @State private var currentDay = Weekday.none
    
    @State private var selectedCategory = "N/A"
    
    @State var selectedColor: TaskColor = .noColor
    let colors: [TaskColor] = [
        .red,
        .green,
        .blue,
        .purple
    ]
    
    @State private var importance = ImportanceLevel.level0
    let importances = [
        ImportanceLevel.level1,
        ImportanceLevel.level2
    ]
    
    @State private var selectedDay = Weekday.none
    
    // Computed properties for tasks on each weekday
    var mondayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay == .monday }
    }
    var tuesdayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay == .tuesday }
    }
    var wednesdayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay == .wednesday }
    }
    var thursdayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay == .thursday }
    }
    var fridayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay == .friday }
    }
    var generalTasks: [TaskItem] {
        // .none corresponds to no weekday
        taskItems.filter { $0.weekDay == .none }
    }
    
    /// Defines all columns to display in the UI in order,
    /// along with their corresponding tasks and weekday.
    private var dailyColumns: [(label: String, tasks: [TaskItem], weekday: Weekday?, date: Int? )] {
        [
            ("Monday",    mondayTasks,    .monday,    dateForWeekday(.monday)),
            ("Tuesday",   tuesdayTasks,   .tuesday,   dateForWeekday(.tuesday)),
            ("Wednesday", wednesdayTasks, .wednesday, dateForWeekday(.wednesday)),
            ("Thursday",  thursdayTasks,  .thursday,  dateForWeekday(.thursday)),
            ("Friday",    fridayTasks,    .friday,    dateForWeekday(.friday)),
            ("General",   generalTasks,   nil,        nil),
        ]
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // The top HStack with columns for each day
                HStack(spacing: 10) {
                    ForEach(dailyColumns.indices, id: \.self) { index in
                        // Put a divider between columns (but not before the first one)
                        if index != 0 {
                            Divider()
                        }
                        
                        let data = dailyColumns[index]
                        DayColumn(
                            label: data.label,
                            date: data.date,
                            tasks: data.tasks,
                            onDrop: { droppedTasks in
                                handleDrop(droppedTasks, newDay: data.weekday)
                            },
                            onDeleteAllTasks: {
                                deleteAllTasks(for: data.weekday)
                            },
                            onMarkAllCompleted: {
                                completeAllTasks(for: data.weekday)
                            }
                        )
                    }
                }
                
                Divider()
                
                // The bottom bar with color pickers, day pickers, importance pickers, and text field
                HStack(spacing: 25) {
                    
                    // Color Picker Row
                    HStack(spacing: 7.5) {
                        ForEach(colors, id: \.self) { color in
                            Button(action: {
                                withAnimation {
                                    selectedColor = (selectedColor == color) ? .noColor : color
                                }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            selectedColor == color
                                            ? Color(hex: color.rawValue).opacity(0.75)
                                            : Color.white.opacity(0.05)
                                        )
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white.opacity(0.25), lineWidth: selectedColor == color ? 0 : 1)
                                        )
                                        .frame(width: 22.5, height: 22.5)
                                    Circle()
                                        .fill(Color(hex: color.rawValue).opacity(0.6))
                                        .frame(width: 10, height: 10)
                                }
                            }
                            .buttonStyle(.plain)
                            .buttonBorderShape(.circle)
                        }
                    }
                    
                    // Day Picker Row
                    HStack(spacing: 7.5) {
                        ForEach([Weekday.monday, .tuesday, .wednesday, .thursday, .friday], id: \.self) { day in
                            Button(action: {
                                withAnimation {
                                    selectedDay = (selectedDay == day) ? .none : day
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(
                                            selectedDay == day
                                            ? Color.white.opacity(0.7)
                                            : Color.white.opacity(0.05)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.white.opacity(0.25), lineWidth: selectedDay == day ? 0 : 1)
                                        )
                                        .frame(width: 30, height: 22.5)
                                    Text(day.rawValue.prefix(1))
                                        .foregroundStyle(selectedDay == day ? .black : .white)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    // Importance Picker Row
                    HStack(spacing: 7.5) {
                        ForEach(importances, id: \.self) { level in
                            Button(action: {
                                withAnimation {
                                    importance = (importance == level) ? .level0 : level
                                }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            importance == level
                                            ? Color.white.opacity(0.7)
                                            : Color.white.opacity(0.05)
                                        )
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white.opacity(0.25), lineWidth: importance == level ? 0 : 1)
                                        )
                                        .frame(width: 22.5, height: 22.5)
                                    Text(level.rawValue)
                                        .foregroundStyle(importance == level ? .black : .white)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(.plain)
                            .buttonBorderShape(.circle)
                        }
                    }
                    
                    // Text Field for adding new tasks
                    TextField("What next?", text: $textEntry)
                        .textFieldStyle(.plain)
                        .padding(2.5)
                        .frame(height: 22.5)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .offset(x: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .onSubmit {
                            withAnimation {
                                addTask()
                            }
                            textEntry = ""
                        }
                }
                .padding(.top, 10)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .transition(.slide)
        .background(.ultraThinMaterial)
        .onAppear {
            selectedColor = .noColor
            importance = .level0
            
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let weekday = dateFormatter.string(from: currentDate)
            
            switch weekday {
            case "Monday":
                selected = .monday
                currentDay = .monday
            case "Tuesday":
                selected = .tuesday
                currentDay = .tuesday
            case "Wednesday":
                selected = .wednesday
                currentDay = .wednesday
            case "Thursday":
                selected = .thursday
                currentDay = .thursday
            case "Friday":
                selected = .friday
                currentDay = .friday
            default:
                selected = .monday
                currentDay = .none
            }
        }
    }
    
    // MARK: - Helper Functions
    
    /// Handles dropping a task onto a particular day (or none).
    func handleDrop(_ droppedTasks: [String], newDay: Weekday?) -> Bool {
        do {
            for taskID in droppedTasks {
                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == taskID }) else {
                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                }
                let originalTask = taskItems[index]
                
                // Create a new task with updated weekday
                let newTask = TaskItem(
                    taskName: originalTask.taskName,
                    weekDay: newDay ?? .none,
                    importance: originalTask.importance,
                    category: originalTask.category,
                    taskColor: originalTask.taskColor
                )
                
                // Remove the original task, insert the new one
                deleteItem(item: originalTask)
                modelContext.insert(newTask)
            }
            return true
        } catch {
            print("Error processing drop: \(error)")
            return false
        }
    }
    
    func deleteItem(item: TaskItem) {
        modelContext.delete(item)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func deleteAllTasks(for weekday: Weekday?) {
        let tasksToDelete = taskItems.filter { $0.weekDay == (weekday ?? .none) }
        tasksToDelete.forEach { deleteItem(item: $0) }
    }
    
    func completeAllTasks(for weekday: Weekday?) {
        withAnimation {
            let tasksToComplete = taskItems.filter { $0.weekDay == (weekday ?? .none) }
            // Mark all filtered tasks as completed
            for task in tasksToComplete {
                task.completed = true
            }
            do {
                try modelContext.save()
            } catch {
                print("Failed to save after marking tasks complete: \(error.localizedDescription)")
            }
        }
    }
    
    func addTask() {
        let trimmed = textEntry.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            print("No task entered")
            return
        }
        
        let newTask = TaskItem(
            taskName: trimmed,
            weekDay: selectedDay,
            importance: importance,
            category: selectedCategory,
            taskColor: selectedColor
        )
        
        withAnimation(.spring()) {
            modelContext.insert(newTask)
            do {
                try modelContext.save()
            } catch {
                print("Failed to save new task: \(error.localizedDescription)")
            }
        }
        textEntry = ""
    }
    
    func countCompletedTasks() -> Int {
        taskItems.filter { $0.completed }.count
    }
    
    /// Returns the day of the month for the given weekday (this week's instance of that day),
    /// or `nil` if it can't be computed.
    private func dateForWeekday(_ weekday: Weekday?) -> Int? {
        guard let weekday = weekday, weekday != .none else { return nil }
        
        let calendar = Calendar.current
        
        // Find the Monday of the current week.
        // (This uses .yearForWeekOfYear and .weekOfYear to get "this week's Monday".)
        guard let mondayThisWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        ) else {
            return nil
        }

        // Offset depends on which weekday we're looking for:
        let dayOffset: Int
        switch weekday {
            case .monday:    dayOffset = 1
            case .tuesday:   dayOffset = 2
            case .wednesday: dayOffset = 3
            case .thursday:  dayOffset = 4
            case .friday:    dayOffset = 5
            default:         dayOffset = 0
        }

        // Add the offset to Monday’s date and extract just the day number.
        if let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: mondayThisWeek) {
            return calendar.component(.day, from: targetDate)
        }
        return nil
    }
}

// MARK: - Subview for each day/column

/// A reusable column for displaying tasks for a specific weekday (or 'General').
struct DayColumn: View {
    let label: String
    let date: Int?
    let tasks: [TaskItem]
    let onDrop: ([String]) -> Bool
    let onDeleteAllTasks: () -> Void
    let onMarkAllCompleted: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                // If `date` is available, show "Monday 13"; otherwise show just "Monday"
                HStack(spacing: 3) {
                    Text(label)
                        .foregroundStyle(isAllCompleted ? .white.opacity(0.5) : .white)
                        .strikethrough(isAllCompleted, color: .white.opacity(0.5))
                    
                    if let date = date {
                        Text(String(date))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // The three-dots menu
                    Menu() {
                        Button(action: onMarkAllCompleted) {
                            HStack {
                                Image(systemName: "checkmark.circle")
                                Text("Complete All")
                            }
                        }
                        Button(role: .destructive, action: onDeleteAllTasks) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Delete All")
                            }
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                        }
                        .frame(width: 17.5, height: 17.5)
                        .background(.white.opacity(0.05))
                        .cornerRadius(5)
                    }
                    .menuStyle(.button)
                    .buttonStyle(.plain)
                }
                .font(.headline)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                
                //Spacer()
            }
            
            // If no tasks, show placeholder
            if tasks.isEmpty {
                HStack {
                    Text("Nothing planned for today!")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .fontDesign(.rounded)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(.vertical, 2.5)
            } else {
                // Show tasks
                ForEach(tasks, id: \.self) { item in
                    TaskComponent(item: item)
                        .draggable(item.id.uuidString)
                }
            }
            Spacer()
        }
        //.frame(width: width)
        .frame(minWidth: 150, maxWidth: .infinity)
        .layoutPriority(1)
        .padding(.top, 7.5)
        .animation(.spring(), value: tasks)
        .dropDestination(for: String.self) { droppedTasks, _ in
            onDrop(droppedTasks)
        }
    }

    private var isAllCompleted: Bool {
        !tasks.isEmpty && tasks.allSatisfy { $0.completed }
    }
}

// MARK: - Preview

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskItem.self, UserData.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
}
