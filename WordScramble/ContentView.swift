//
//  ContentView.swift
//  WordScramble
//
//  Created by Davron on 12/3/19.
//  Copyright © 2019 Davron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
    
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
        .navigationBarTitle(rootWord)
        }
    }
    
    func addNewWord() {
        //lowercase and trim the word, to make sure we dont add dublicate words with case differences
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //exit if the remaining string is empty
        guard word.count > 0 else {
            return
        }
        usedWords.insert(word, at: 0)
        newWord = ""
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
