//
//  JokeViewModel.swift
//  JokeFinder
//
//  Created by Thomas Noone on 2025-03-05.
//

import Foundation
 
@Observable
class JokeViewModel {
    
    // MARK: Stored properties
    
    // Whatever joke has most recently been downloaded
    // from the endpoint
    var currentJoke: JokeModel?
    
    // MARK: Initializer(s)
    init(currentJoke: JokeModel? = nil) {
        
        // Take whatever joke was provided when an instance of
        // this view model is created, and make it the current joke.
        //
        // Otherwise, the default value for the current joke
        // will be a nil.
        self.currentJoke = currentJoke
    }
    
}
