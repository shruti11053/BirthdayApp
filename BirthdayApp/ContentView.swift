//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Shruti Shivakumar on 7/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        
    
        
        NavigationStack {
            //this is an ARRAY
            List(friends, id: \.name) { friend in
                
                HStack{
                    
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format:
                            .dateTime.month(.wide).day().year())
                    
                }
                
                .navigationTitle("Birthdays")
                
            
                    }
            
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    
                    DatePicker(selection: $newBirthday, in:
                    Date.distantPast...Date.now,
                    displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    //after you input the information, the save button will add it to the array
                    
                    Button("Save"){
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                
            }
            
        }
        
        
        
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true )
}
