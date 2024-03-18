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
    @Query private var items: [Item]
    
    @State private var isOn: Bool = false
    @State private var isOn2: Bool = false
    
    @State private var textEntry: String = ""
    @State private var selected = 1


    var body: some View {
        VStack {
            
            HStack {
                Text("Peek")
                    .font(.headline)
                    .fontWeight(.semibold)
                
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
                
                HStack {
                    Image(systemName: "paintbrush.pointed.fill")
                        .resizable()
                        .frame(width: 17.5, height: 17.5)
                    
                    Text("3540 HW")
                        .strikethrough(isOn)
                        .foregroundStyle(isOn ? .gray : .white)
                        .onTapGesture {
                            withAnimation {
                                isOn.toggle()
                            }
                        }
                    
                    Spacer()
                    
                    Text("!!")

                }
                .padding(.vertical, 2.5)
                
                HStack {
                    Image(systemName: "angle")
                        .resizable()
                        .frame(width: 17.5, height: 15)
                    
                    Text("PHYS HW")
                        .strikethrough(isOn2)
                        .foregroundStyle(isOn2 ? .gray : .white)
                        .onTapGesture {
                            withAnimation {
                                isOn2.toggle()
                            }
                        }
                    Spacer()
                }
                .padding(.vertical, 2.5)
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Tuesday")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack {
                    Text("Nothing planned for today!")
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(.vertical, 2.5)
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Wednesday")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack {
                    Text("Nothing planned for today!")
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                .padding(.vertical, 2.5)
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Thursday")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack {
                    Text("Nothing planned for today!")
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                .padding(.vertical, 2.5)
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Friday")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack {
                    Text("Nothing planned for today!")
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                .padding(.vertical, 2.5)
            }
            
            Divider()
            
            VStack(spacing: 10) {
                
                TextField("Any Tasks?", text: $textEntry)
                    .textFieldStyle(.plain)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5) // Set your desired corner radius
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Set the border color and line width
                    )
                
                Picker(selection: $selected, label: Image(systemName: "calendar")) {
                                Text("M").tag(1)
                                Text("T").tag(2)
                                Text("W").tag(3)
                                Text("Th").tag(4)
                                Text("F").tag(5)
                            }
                .pickerStyle(.segmented)
                            .horizontalRadioGroupLayout()
                
            }
            .padding(.vertical, 5)
            
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        //.frame(height: 500)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
