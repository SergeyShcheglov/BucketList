//
//  ContentView.swift
//  BucketList
//
//  Created by Sergey Shcheglov on 15.02.2022.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Sergey", lastName: "Shcheglov"),
        User(firstName: "Pavel", lastName: "Zagorodnikh"),
        User(firstName: "Grigory", lastName: "Moroz"),
    ].sorted()
    
    var body: some View {
        Text("Hello, World")
            .onTapGesture {
                let str = "Test message"
                let url = FileManager().getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
//        func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            return paths[0]
//        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
