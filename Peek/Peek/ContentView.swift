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
    
    @State private var selectedCategory = "N/A"
    
    var importances = ["N/A", "!", "!!"]
    @State private var importance = ImportanceLevel.level0

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
                    
                    Text("0/2")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Monday")
                            .font(.headline)
                            .fontWeight(.semibold)
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
                            
                            HStack {
                                
                                Text(item.taskName)
                                    .strikethrough(item.completed)
                                    .foregroundStyle(item.completed ? .gray : .white)
                                    .onTapGesture {
                                        withAnimation {
                                            item.completed.toggle()
                                        }
                                    }
                                
                                Spacer()
                                
                                if item.category != "N/A" {
                                    Text(item.category)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(item.importance.rawValue)
                                
                            }
                            .padding(.vertical, 2.5)
                            .transition(.opacity)
                            
                        }
                    }
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Tuesday")
                            .font(.headline)
                            .fontWeight(.semibold)
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
                            
                            HStack {
                                
                                Text(item.taskName)
                                    .strikethrough(item.completed)
                                    .foregroundStyle(item.completed ? .gray : .white)
                                    .onTapGesture {
                                        withAnimation {
                                            item.completed.toggle()
                                        }
                                    }
                                
                                Spacer()
                                
                                if item.category != "N/A" {
                                    Text(item.category)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(item.importance.rawValue)
                                
                            }
                            .padding(.vertical, 2.5)
                            .transition(.opacity)

                        }
                    }
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Wednesday")
                            .font(.headline)
                            .fontWeight(.semibold)
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
                            
                            HStack {
                                
                                Text(item.taskName)
                                    .strikethrough(item.completed)
                                    .foregroundStyle(item.completed ? .gray : .white)
                                    .onTapGesture {
                                        withAnimation {
                                            item.completed.toggle()
                                        }
                                    }
                                
                                Spacer()
                                
                                if item.category != "N/A" {
                                    Text(item.category)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(item.importance.rawValue)
                                
                            }
                            .padding(.vertical, 2.5)
                            .transition(.opacity)

                        }
                    }
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Thursday")
                            .font(.headline)
                            .fontWeight(.semibold)
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
                            
                            HStack {
                                
                                Text(item.taskName)
                                    .strikethrough(item.completed)
                                    .foregroundStyle(item.completed ? .gray : .white)
                                    .onTapGesture {
                                        withAnimation {
                                            item.completed.toggle()
                                        }
                                    }
                                
                                Spacer()
                                
                                if item.category != "N/A" {
                                    Text(item.category)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(item.importance.rawValue)
                                
                            }
                            .padding(.vertical, 2.5)
                            .transition(.opacity)

                        }
                    }
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Friday")
                            .font(.headline)
                            .fontWeight(.semibold)
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
                            
                            HStack {
                                
                                Text(item.taskName)
                                    .strikethrough(item.completed)
                                    .foregroundStyle(item.completed ? .gray : .white)
                                    .onTapGesture {
                                        withAnimation {
                                            item.completed.toggle()
                                        }
                                    }
                                
                                Spacer()
                                
                                if item.category != "N/A" {
                                    Text(item.category)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(item.importance.rawValue)
                                
                            }
                            .padding(.vertical, 2.5)
                            .transition(.opacity)

                        }
                    }
                }
                
                Divider()
                
                VStack(spacing: 10) {
                                        
                        Picker(selection: $selected, label: Text("")) {
                            Text("M").tag(Weekday.monday)
                            Text("T").tag(Weekday.tuesday)
                            Text("W").tag(Weekday.wednesday)
                            Text("Th").tag(Weekday.thursday)
                            Text("F").tag(Weekday.friday)
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                    
                        Picker("", selection: $selectedCategory) {
                            ForEach(userDataArray.first?.categories ?? ["N/A"], id: \.self) {
                                Text($0)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                    
                    
                    Picker(selection: $importance, label: Text("")) {
                        Text("N/A").tag(ImportanceLevel.level0)
                        Text("!").tag(ImportanceLevel.level1)
                        Text("!!").tag(ImportanceLevel.level2)
                    }
                    .labelsHidden()
                    .pickerStyle(.segmented)
                    
                    TextField("Any Tasks?", text: $textEntry)
                        .textFieldStyle(.plain)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5) // Set your desired corner radius
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Set the border color and line width
                        )
                        .padding(.vertical, 5)
                        .onSubmit {
                            withAnimation {
                                addTask()
                            }
                        }
                }
                .padding(.top, 5)
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .onAppear() {
//            do {
//                try modelContext.delete(model: UserData.self)
//                try modelContext.delete(model: TaskItem.self)
//            } catch {
//                print("error")
//            }
//            
//            let data = UserData()
//            modelContext.insert(data)
        }
        //.frame(height: 700)
    }
    
    func addTask() {
            let newTask = TaskItem(taskName: textEntry, weekDay: selected, importance: importance, category: selectedCategory)
            modelContext.insert(newTask)
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
    
    let task1 = TaskItem(taskName: "Take out trash", weekDay: .tuesday, importance: .level1, category: "Personal")
    container.mainContext.insert(task1)

    return ContentView()
           .modelContainer(container)
}
