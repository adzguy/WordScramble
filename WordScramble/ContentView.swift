//
//  ContentView.swift
//  WordScramble
//
//  Created by Davron on 12/3/19.
//  Copyright © 2019 Davron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section(header: Text("Section 1")){
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
            }

            Section(header: Text("Section 2")){
                ForEach(0..<5) {
                    Text("Dynamuc row \($0)")
                }
            }

            Section(header: Text("Section 3")) {
                Text("Static row 3")
                Text("Statuc row 4")
            }
        }
    .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
