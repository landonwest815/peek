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
        ZStack {
            VStack(spacing: 0) {
                VStack{
                    HStack {
                        
                        ZStack {
                            //Text(contents)
                            Text(item.taskName)
                                .strikethrough(item.completed)
                                .foregroundStyle(.white)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                            
                        }
                        
                        Spacer()
                        
                        //                    if item.category != "N/A" {
                        //                        Text(item.category)
                        //                            .foregroundStyle(.gray)
                        //                    }
                        
                        Text(item.importance.rawValue)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .font(.headline)
                        
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .font(.headline)
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
            .background(
                item.taskColor == .noColor ? .white.opacity(0.15) : Color(hex: item.taskColor.rawValue).opacity(0.7)
            )
            //.background(.ultraThickMaterial)
            .cornerRadius(7.5)
            .overlay(
                RoundedRectangle(cornerRadius: 7.5, style: .circular).stroke((Color(hex: item.taskColor == .noColor ? "808080" : item.taskColor.rawValue)).opacity(0.75), lineWidth: 1)
            )
            .opacity(item.completed ? 0.33 : 1.0)
            .shadow(color: .black, radius: 0.5)
        }
        //.shadow(color: .black, radius: 0.5)
    }
}

extension UTType {
    static let taskComponent = UTType(exportedAs: "co.landonwest.taskComponent")
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskItem.self, UserData.self, configurations: config)
    
    let task1 = TaskItem(taskName: "Take out trash", weekDay: .tuesday, importance: .level1, category: "Personal", taskColor: .noColor)
    container.mainContext.insert(task1)
    
    return ZStack {
        TaskComponent(item: task1)
            .modelContainer(container)
            .padding() // Add padding only for the preview

    }
}
