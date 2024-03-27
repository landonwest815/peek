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

    var body: some View {
        
        ZStack {
            VStack {
                
                HStack {
                    Text("Peek")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("by Landon West")
                        .font(.caption)
                        .fontWeight(.regular)
                    
                    Spacer()
                    
                    Text(taskItems.count == 0 ? "" : "\(Double(countCompletedTasks()) / Double(taskItems.count) * 100, specifier: "%.0f")%")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(taskItems.count == 0 ? "" : "\(countCompletedTasks()) / \(taskItems.count)")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                HStack {
                    
                    VStack {
                        HStack {
                            Text("Monday")
                                .font(.headline)
                                .fontWeight(.semibold)
                            if (currentDay == .monday) {
                                Image(systemName: "arrowtriangle.backward.fill")
                                    .resizable()
                                    .frame(width: 7, height: 10)
                            }
                            Spacer()
                        }
                        
                        if mondayTasks.isEmpty {
                            
                            HStack {
                                Text("Nothing planned for today!")
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
                    .frame(width: 150)
                    .animation(.spring, value: mondayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        for task in droppedTasks {
                            taskItems.first(where: { $0.id.uuidString == task })?.weekDay = .monday
                        }
                        
                        return true
                    }
                        
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Tuesday")
                                .font(.headline)
                                .fontWeight(.semibold)
                            if (currentDay == .tuesday) {
                                Image(systemName: "arrowtriangle.backward.fill")
                                    .resizable()
                                    .frame(width: 7, height: 10)
                            }
                            Spacer()
                        }
                        
                        if tuesdayTasks.isEmpty {
                            
                            HStack {
                                Text("Nothing planned for today!")
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
                    .frame(width: 150)
                    .animation(.spring, value: tuesdayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        for task in droppedTasks {
                            taskItems.first(where: { $0.id.uuidString == task })?.weekDay = .tuesday
                        }
                        
                        return true
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Wednesday")
                                .font(.headline)
                                .fontWeight(.semibold)
                            if (currentDay == .wednesday) {
                                Image(systemName: "arrowtriangle.backward.fill")
                                    .resizable()
                                    .frame(width: 7, height: 10)
                            }
                            Spacer()
                        }
                        
                        if wednesdayTasks.isEmpty {
                            
                            HStack {
                                Text("Nothing planned for today!")
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
                    .frame(width: 150)
                    .animation(.spring, value: wednesdayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        for task in droppedTasks {
                            taskItems.first(where: { $0.id.uuidString == task })?.weekDay = .wednesday
                        }
                        
                        return true
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Thursday")
                                .font(.headline)
                                .fontWeight(.semibold)
                            if (currentDay == .thursday) {
                                Image(systemName: "arrowtriangle.backward.fill")
                                    .resizable()
                                    .frame(width: 7, height: 10)
                            }
                            Spacer()
                        }
                        
                        if thursdayTasks.isEmpty {
                            
                            HStack {
                                Text("Nothing planned for today!")
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
                    .frame(width: 150)
                    .animation(.spring, value: thursdayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        for task in droppedTasks {
                            taskItems.first(where: { $0.id.uuidString == task })?.weekDay = .thursday
                        }
                        
                        return true
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Friday")
                                .font(.headline)
                                .fontWeight(.semibold)
                            if (currentDay == .friday) {
                                Image(systemName: "arrowtriangle.backward.fill")
                                    .resizable()
                                    .frame(width: 7, height: 10)
                            }
                            Spacer()
                        }
                        
                        if fridayTasks.isEmpty {
                            
                            HStack {
                                Text("Nothing planned for today!")
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
                    .frame(width: 150)
                    .animation(.spring, value: fridayTasks)
                    .dropDestination(for: String.self) { droppedTasks, location in
                        for task in droppedTasks {
                            taskItems.first(where: { $0.id.uuidString == task })?.weekDay = .friday
                        }
                        
                        return true
                    }
                    
                }
                    
                Divider()
                
                ZStack {
                    HStack(spacing: 12.5) {
                        //                        Picker("", selection: $selectedCategory) {
                        //                            ForEach(userDataArray.first?.categories ?? ["N/A"], id: \.self) {
                        //                                Text($0)
                        //                            }
                        //                        }
                        //                        .labelsHidden()
                        //                        .pickerStyle(.menu)
                        //                        .tint(.gray)
                        //                        .frame(width: 105)
                        
                        HStack(spacing: 10) {
                            ForEach(colors, id: \.self) { color in
                                Button(action: {
                                    if self.selectedColor.rawValue == color.rawValue {
                                        self.selectedColor = .noColor
                                    } else {
                                        self.selectedColor = color
                                    }
                                }) {
                                    Circle()
                                        .fill(Color(hex: color.rawValue) ?? .red)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: self.selectedColor == color ? 3 : 0)
                                        )
                                }
                                .buttonBorderShape(.circle)
                            }
                        }
                        
                        Picker(selection: $selected, label: Text("")) {
                            Text("M").tag(Weekday.monday)
                            Text("T").tag(Weekday.tuesday)
                            Text("W").tag(Weekday.wednesday)
                            Text("Th").tag(Weekday.thursday)
                            Text("F").tag(Weekday.friday)
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                        .frame(width: 175)
                        
//                        Picker(selection: $importance, label: Text("")) {
//                            Text("N/A").tag(ImportanceLevel.level0)
//                            Text("!").tag(ImportanceLevel.level1)
//                            Text("!!").tag(ImportanceLevel.level2)
//                        }
//                        .labelsHidden()
//                        .pickerStyle(.segmented)
//                        .tint(.gray)
//                        .frame(width: 105)
                        
                        HStack(spacing: 10) {
                            ForEach(importances, id: \.self) { importance in
                                Button(action: {
                                    if self.importance.rawValue == importance.rawValue {
                                        self.importance = .level0
                                    } else {
                                        self.importance = importance
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(.darkGray).opacity(0.7))
                                            .frame(width: 20, height: 20)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: self.importance == importance ? 3 : 0)
                                            )
                                        Text(importance.rawValue)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .buttonBorderShape(.circle)
                            }
                        }
                        
                        
                        TextField(" Any Tasks?", text: $textEntry)
                            .textFieldStyle(.plain)
                            .padding(2.5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5) // Set your desired corner radius
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
                .padding(5)
                    
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .transition(.slide)
        .background(.thinMaterial)
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
        try? modelContext.save()
    }
    
    func countCompletedTasks() -> Int {
        let completedTasks = taskItems.filter { $0.completed == true }
        return completedTasks.count
    }
    
    func addTask() {
            let newTask = TaskItem(taskName: textEntry, weekDay: selected, importance: importance, category: selectedCategory, taskColor: selectedColor)
        withAnimation(.spring()) {
            modelContext.insert(newTask)
        }
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
