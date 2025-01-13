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

    @State private var isOn: Bool = false
    @State private var isOn2: Bool = false
    
    @State private var textEntry: String = ""
    @State private var selected = Weekday.monday
    @State private var currentDay = Weekday.none

    
    @State private var selectedCategory = "N/A"
    
    @State var selectedColor: TaskColor = .noColor
    let colors: [TaskColor] = [
        TaskColor.red,
        TaskColor.green,
        TaskColor.blue,
        TaskColor.purple,
    ]
    
    @State private var importance = ImportanceLevel.level0
    var importances = [
        ImportanceLevel.level1,
        ImportanceLevel.level2,
    ]
    
    @State private var selectedDay = Weekday.none
    var weekdays = [
        Weekday.monday,
        Weekday.tuesday,
        Weekday.wednesday,
        Weekday.thursday,
        Weekday.friday,
    ]

    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                
//                HStack(spacing: 5) {
//                    Image(systemName: "pencil.and.scribble")
//                        .font(.headline)
//                    
//                    Text("Peek")
//                        .font(.headline)
//                        .fontWeight(.semibold)
//                    
//                    Spacer()
//                    
//                    Text(taskItems.count == 0 ? "" : "\(Double(countCompletedTasks()) / Double(taskItems.count) * 100, specifier: "%.0f")%")
//                        .font(.headline)
//                        .fontWeight(.semibold)
//                    
//                    Text(taskItems.count == 0 ? "" : "\(countCompletedTasks()) / \(taskItems.count)")
//                        .font(.headline)
//                        .fontWeight(.semibold)
//                }
//                .padding(.bottom, 7.5)
                
                //Divider()
                
                HStack {
                    
                    VStack {
                        HStack {
                            Text("Monday")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
//                            if (currentDay == .monday) {
//                                Image(systemName: "arrowtriangle.backward.fill")
//                                    .resizable()
//                                    .frame(width: 7, height: 10)
//                            }
                            Spacer()
                        }
                        
                        if mondayTasks.isEmpty {
                            
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
                            ForEach(mondayTasks, id: \.self) { item in
                                
                                TaskComponent(item: item)
                                    .draggable(item.id.uuidString)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 7.5)
                    .frame(width: 150)
                    .animation(.spring, value: mondayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        do {
                            try droppedTasks.forEach { task in
                                // Find the index of the original task to be removed
                                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == task }) else {
                                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                                }
                                
                                // Create a new task based on the original task details but with a different weekday
                                let originalTask = taskItems[index]
                                let newTask = TaskItem(taskName: originalTask.taskName, weekDay: .monday, importance: originalTask.importance, category: originalTask.category, taskColor: originalTask.taskColor)
                                
                                // Remove the original task from the array
                                deleteItem(item: originalTask)
                                
                                modelContext.insert(newTask)
                                
                            }
                            return true
                        } catch let error {
                            print("Error processing drop: \(error)")
                            return false
                        }
                    }
                        
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Tuesday")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
//                            if (currentDay == .tuesday) {
//                                Image(systemName: "arrowtriangle.backward.fill")
//                                    .resizable()
//                                    .frame(width: 7, height: 10)
//                            }
                            Spacer()
                        }
                        
                        if tuesdayTasks.isEmpty {
                            
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
                            ForEach(tuesdayTasks, id: \.self) { item in
                                
                                TaskComponent(item: item)
                                    .draggable(item.id.uuidString)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 7.5)
                    .frame(width: 150)
                    .animation(.spring, value: tuesdayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        do {
                            try droppedTasks.forEach { task in
                                // Find the index of the original task to be removed
                                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == task }) else {
                                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                                }
                                
                                // Create a new task based on the original task details but with a different weekday
                                let originalTask = taskItems[index]
                                let newTask = TaskItem(taskName: originalTask.taskName, weekDay: .tuesday, importance: originalTask.importance, category: originalTask.category, taskColor: originalTask.taskColor)
                                
                                // Remove the original task from the array
                                deleteItem(item: originalTask)
                                
                                modelContext.insert(newTask)
                                
                            }
                            return true
                        } catch let error {
                            print("Error processing drop: \(error)")
                            return false
                        }
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Wednesday")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
//                            if (currentDay == .wednesday) {
//                                Image(systemName: "arrowtriangle.backward.fill")
//                                    .resizable()
//                                    .frame(width: 7, height: 10)
//                            }
                            Spacer()
                        }
                        
                        if wednesdayTasks.isEmpty {
                            
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
                            ForEach(wednesdayTasks, id: \.self) { item in
                                
                                TaskComponent(item: item)
                                    .draggable(item.id.uuidString)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 7.5)
                    .frame(width: 150)
                    .animation(.spring, value: wednesdayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        do {
                            try droppedTasks.forEach { task in
                                // Find the index of the original task to be removed
                                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == task }) else {
                                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                                }
                                
                                // Create a new task based on the original task details but with a different weekday
                                let originalTask = taskItems[index]
                                let newTask = TaskItem(taskName: originalTask.taskName, weekDay: .wednesday, importance: originalTask.importance, category: originalTask.category, taskColor: originalTask.taskColor)
                                
                                // Remove the original task from the array
                                deleteItem(item: originalTask)
                                
                                modelContext.insert(newTask)
                                
                            }
                            return true
                        } catch let error {
                            print("Error processing drop: \(error)")
                            return false
                        }
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Thursday")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
//                            if (currentDay == .thursday) {
//                                Image(systemName: "arrowtriangle.backward.fill")
//                                    .resizable()
//                                    .frame(width: 7, height: 10)
//                            }
                            Spacer()
                        }
                        
                        if thursdayTasks.isEmpty {
                            
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
                            ForEach(thursdayTasks, id: \.self) { item in
                                
                                TaskComponent(item: item)
                                    .draggable(item.id.uuidString)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 7.5)
                    .frame(width: 150)
                    .animation(.spring, value: thursdayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        do {
                            try droppedTasks.forEach { task in
                                // Find the index of the original task to be removed
                                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == task }) else {
                                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                                }
                                
                                // Create a new task based on the original task details but with a different weekday
                                let originalTask = taskItems[index]
                                let newTask = TaskItem(taskName: originalTask.taskName, weekDay: .thursday, importance: originalTask.importance, category: originalTask.category, taskColor: originalTask.taskColor)
                                
                                // Remove the original task from the array
                                deleteItem(item: originalTask)
                                
                                modelContext.insert(newTask)
                                
                            }
                            return true
                        } catch let error {
                            print("Error processing drop: \(error)")
                            return false
                        }
                    }

                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Friday")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
//                            if (currentDay == .friday) {
//                                Image(systemName: "arrowtriangle.backward.fill")
//                                    .resizable()
//                                    .frame(width: 7, height: 10)
//                            }
                            Spacer()
                        }
                        
                        if fridayTasks.isEmpty {
                            
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
                            ForEach(fridayTasks, id: \.self) { item in
                                
                                TaskComponent(item: item)
                                    .draggable(item.id.uuidString)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 7.5)
                    .frame(width: 150)
                    .animation(.spring, value: fridayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        do {
                            try droppedTasks.forEach { task in
                                // Find the index of the original task to be removed
                                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == task }) else {
                                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                                }
                                
                                // Create a new task based on the original task details but with a different weekday
                                let originalTask = taskItems[index]
                                let newTask = TaskItem(taskName: originalTask.taskName, weekDay: .friday, importance: originalTask.importance, category: originalTask.category, taskColor: originalTask.taskColor)
                                
                                // Remove the original task from the array
                                deleteItem(item: originalTask)
                                
                                modelContext.insert(newTask)
                                
                            }
                            return true
                        } catch let error {
                            print("Error processing drop: \(error)")
                            return false
                        }
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("General")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        if generalTasks.isEmpty {
                            
                            HStack {
                                Text("Nothing planned!")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .padding(.vertical, 2.5)
                            
                        } else {
                            ForEach(generalTasks, id: \.self) { item in
                                
                                TaskComponent(item: item)
                                    .draggable(item.id.uuidString)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 7.5)
                    .frame(width: 150)
                    .animation(.spring, value: generalTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        do {
                            try droppedTasks.forEach { task in
                                // Find the index of the original task to be removed
                                guard let index = taskItems.firstIndex(where: { $0.id.uuidString == task }) else {
                                    throw NSError(domain: "TaskError", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Original task not found"])
                                }
                                
                                // Create a new task based on the original task details but with a different weekday
                                let originalTask = taskItems[index]
                                let newTask = TaskItem(taskName: originalTask.taskName, weekDay: .none, importance: originalTask.importance, category: originalTask.category, taskColor: originalTask.taskColor)
                                
                                // Remove the original task from the array
                                deleteItem(item: originalTask)
                                
                                modelContext.insert(newTask)
                                
                            }
                            return true
                        } catch let error {
                            print("Error processing drop: \(error)")
                            return false
                        }
                    }

                    
                }
                    
                Divider()
                
                ZStack {
                    HStack(spacing: 25) {
                        
                        HStack(spacing: 7.5) {
                            ForEach(colors, id: \.self) { color in
                                Button(action: {
                                    withAnimation {
                                        if self.selectedColor.rawValue == color.rawValue {
                                            self.selectedColor = .noColor
                                        } else {
                                            self.selectedColor = color
                                        }
                                    }
                                }) {
                                    Circle()
                                        .fill((Color(hex: color.rawValue)).opacity(0.6))
                                        .frame(width: 22.5, height: 22.5)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: self.selectedColor == color ? 3 : 0)
                                        )
                                }
                                .buttonBorderShape(.circle)
                            }
                        }
                        
                        // Day Picker
                        HStack(spacing: 7.5) {
                            ForEach(weekdays, id: \.self) { day in
                                Button(action: {
                                    withAnimation {
                                        if self.selectedDay == day {
                                            self.selectedDay = .none
                                        } else {
                                            self.selectedDay = day
                                        }
                                    }
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5) // Adjust corner radius as needed
                                            .fill(self.selectedDay == day ? Color.white.opacity(0.7) : Color(.darkGray).opacity(0.7)) // Background color
                                            .frame(width: 30, height: 22.5) // Adjust width and height as needed
                                        Text(day.rawValue.prefix(1)) // Display first letter of the day
                                            .foregroundStyle(self.selectedDay == day ? .black : .white)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .fontDesign(.rounded)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        HStack(spacing: 7.5) {
                            ForEach(importances, id: \.self) { importance in
                                Button(action: {
                                    withAnimation {
                                        if self.importance.rawValue == importance.rawValue {
                                            self.importance = .level0
                                        } else {
                                            self.importance = importance
                                        }
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(self.importance == importance ? Color.white.opacity(0.7) : Color(.darkGray).opacity(0.7))
                                            .frame(width: 22.5, height: 22.5)
                                            
                                        Text(importance.rawValue)
                                            .foregroundStyle(self.importance == importance ? .black : .white)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .fontDesign(.rounded)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        
                        TextField("Any Tasks?", text: $textEntry)
                            .textFieldStyle(.plain)
                            .padding(2.5)
                            .frame(height: 22.5)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .offset(x: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12) // Set your desired corner radius
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Set the border color and line width
                            )
                            .onSubmit {
                                withAnimation {
                                    addTask()
                                }
                                textEntry = ""
                            }
                    }
                    
                }
                .padding(.top, 10)
                    
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .transition(.slide)
        .background(.ultraThinMaterial)
        .onAppear() {
//            do {
//                try modelContext.delete(model: UserData.self)
//                try modelContext.delete(model: TaskItem.self)
//                try? modelContext.save()
//            } catch {
//                print("error")
//            }
//            
//            let data = UserData()
//            modelContext.insert(data)
            
            selectedColor = .noColor
            importance = .level0
            
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // Returns the full name of the weekday
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
        //.frame(height: 700)
    }
        
    func deleteItem(item: TaskItem) {
        modelContext.delete(item)
        
        do {
            try modelContext.save()
        } catch {
            // Handle the error appropriately
            print("Failed to save context: \(error.localizedDescription)")
            
            // Optionally, you could also include more sophisticated error handling such as:
            // - Informing the user with a user-friendly message
            // - Attempting to recover or rollback changes
            // - Logging the error to a file or analytics service for further investigation
        }
    }
    
    func countCompletedTasks() -> Int {
        let completedTasks = taskItems.filter { $0.completed == true }
        return completedTasks.count
    }
    
    func addTask() {
        if textEntry.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print("No task entered")
            return
        }
        let newTask = TaskItem(taskName: textEntry, weekDay: selectedDay, importance: importance, category: selectedCategory, taskColor: selectedColor)
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
    
    var mondayTasks: [TaskItem] {
            taskItems.filter { $0.weekDay.rawValue == "Monday" }
    }
    
    var tuesdayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay.rawValue == "Tuesday" }
    }
    
    var wednesdayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay.rawValue == "Wednesday" }
    }
    
    var thursdayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay.rawValue == "Thursday" }
    }
    
    var fridayTasks: [TaskItem] {
        taskItems.filter { $0.weekDay.rawValue == "Friday" }
    }
    
    var generalTasks: [TaskItem] {
        taskItems.filter { $0.weekDay.rawValue == "" }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskItem.self, UserData.self, configurations: config)
    
//    let data = UserData()
//    container.mainContext.insert(data)
//    
//    let task1 = TaskItem(taskName: "Take out trash", weekDay: .tuesday, importance: .level1, category: "Personal")
//    container.mainContext.insert(task1)

    return ContentView()
           .modelContainer(container)
}
