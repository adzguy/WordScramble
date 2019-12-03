//
//  ContentView.swift
//  WordScramble
//
//  Created by Davron on 12/3/19.
//  Copyright © 2019 Davron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let people = ["Finn", "John", "Mark", "Lebap"]
    
    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
//      Or this way its the same
//        List {
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//        }
    .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
