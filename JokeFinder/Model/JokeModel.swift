//
//  Joke.swift
//  JokeFinder
//
//  Created by Thomas Noone on 2025-03-05.
//

import SwiftUI

struct JokeModel: Identifiable, Codable {
    
    // MARK: Stored properties
    let type: String
    let setup: String?
    let punchline: String?
    let id: Int
        
}
 
// Create an example joke for testing purposes
let exampleJoke = JokeModel(
    type: "general",
    setup: "Why couldn't the kid go to see the pirate movie?",
    punchline: "Because it was rated arrrrr!",
    id: 310
)
