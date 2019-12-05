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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var calculateScore: Int {
        var score = 0
        
        for i in 0..<usedWords.count {
            score += usedWords[i].count
        }
        return score
    }
    
    var body: some View {

        NavigationView {
            VStack {
                VStack {
                    Text("score")
                    Text("\(calculateScore)")
                }
                .padding()
                .background(Color.secondary)
                .cornerRadius(20)


                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                List(usedWords, id: \.self) {
                        Image(systemName: "\($0.count).circle")
                        Text($0)
                }
            }
            .navigationBarItems(leading: Button(action: startGame){
                Text("Restar Game")
            })
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    func addNewWord() {
        //lowercase and trim the word, to make sure we don't add dublicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            if answer == rootWord {
                wordError(title: "Nope", message: "Should be different from the root word!")
            }else{
                wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            }
            return
        }
        guard isReal(word: answer) else {
            if answer.count < 3 {
                wordError(title: "Too Short", message: "Must be longer than two letters. Try harder!")
            }else {
                wordError(title: "Word not possible", message: "This isn't a real word")
            }
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into array of strings, splitting on breaks
                let allWords = startWords.components(separatedBy: "\n")
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = [String]()
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        if word == rootWord {
            return false
        }
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        if word.count < 3 {
            return false
        }else {
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            return misspelledRange.location == NSNotFound
        }

    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
