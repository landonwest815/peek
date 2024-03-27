//
//  TaskComponent.swift
//  Peek
//
//  Created by Landon West on 3/20/24.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct TaskComponent: View/*, Hashable, Codable, Transferable*/ {
    
    var id = UUID()
    
    @Environment(\.modelContext) private var modelContext
    
    //var width: CGFloat
    //var height: CGFloat
    //var contents: String
    
    var item: TaskItem

//    static var transferRepresentation: some TransferRepresentation {
//        CodableRepresentation(contentType: .taskComponent)
//    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack{
                HStack {
                    
                    ZStack {
                        //Text(contents)
                        Text(item.taskName)
                            .strikethrough(item.completed)
                            .foregroundStyle(.white)
                        
                    }
                    
                    Spacer()
                    
//                    if item.category != "N/A" {
//                        Text(item.category)
//                            .foregroundStyle(.gray)
//                    }
                    
                    Text(item.importance.rawValue)
                    
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                        .onTapGesture {
                            modelContext.delete(item)
                        }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 2.5)
            .transition(.opacity)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                item.completed.toggle()
            }
        }
        .frame(height: 35)
        .background((Color(hex: item.taskColor.rawValue) ?? .clear).opacity(0.6))
        .cornerRadius(7.5)
        .overlay(
            RoundedRectangle(cornerRadius: 7.5, style: .circular).stroke(Color(.white), lineWidth: 1)
        )
        .opacity(item.completed ? 0.33 : 1.0)
    }
}

extension UTType {
    static let taskComponent = UTType(exportedAs: "co.landonwest.taskComponent")
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskItem.self, UserData.self, configurations: config)
    
    let task1 = TaskItem(taskName: "Take out trash", weekDay: .tuesday, importance: .level1, category: "Personal", taskColor: .green)
    container.mainContext.insert(task1)
    
    return TaskComponent(item: task1)
        .modelContainer(container)
}
