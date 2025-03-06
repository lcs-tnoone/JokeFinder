//
//  ContentView.swift
//  JokeFinder
//
//  Created by Thomas Noone on 2025-03-05.
//

import SwiftUI

struct JokeView: View {
    
    // MARK: Stored properties
    
    // Access the view model from the environment
    @Environment(JokeViewModel.self) var viewModel

    // Controls punchline visibility
    @State var punchlineOpacity = 0.0

    // Starts a timer to wait on revealing punchline
    @State var punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Controls button visibility
    @State var buttonOpacity = 0.0

    // Starts a timer to wait on revealing button to get new joke
    @State var buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    // Controls whether save button is enabled
    @State var jokeHasBeenSaved = false

    
    // MARK: Computed properties
    var body: some View {
        
        
        NavigationStack{
            VStack {
                
                // Show a joke if one exists
                if let currentJoke = viewModel.currentJoke {
                    
                    Group {
                        Text(currentJoke.setup ?? "")
                            .padding(.bottom, 100)
                        
                        Text(currentJoke.punchline ?? "")
                            .opacity(punchlineOpacity)
                            .onReceive(punchlineTimer) { _ in
                                
                                withAnimation {
                                    punchlineOpacity = 1.0
                                }
                                
                                // Stop the timer
                                punchlineTimer.upstream.connect().cancel()
                            }
                        
                        
                    }
                    .font(.title)
                    .multilineTextAlignment(.center)
                    
                    Button {
                        
                        // Save the joke
                        viewModel.saveJoke()
                        
                        // Disable this button until next joke is loaded
                        jokeHasBeenSaved = true
                        
                    } label: {
                        Text("Save for later")
                    }
                    .tint(.green)
                    .buttonStyle(.borderedProminent)
                    .opacity(buttonOpacity)
                    .padding(.bottom, 20)
                    .disabled(jokeHasBeenSaved)
                    
                    
                    Button {
                        
                        // Hide punchline and button
                        withAnimation {
                            viewModel.currentJoke = nil
                            punchlineOpacity = 0.0
                            buttonOpacity = 0.0
                            // Enable save button again
                            jokeHasBeenSaved = false
                        }
                        
                        // Get a new joke
                        Task {
                            await viewModel.fetchJoke()
                        }
                        
                        // Restart timers
                        punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                        buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                        
                    } label: {
                        
                        Text("New Joke")
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .opacity(buttonOpacity)
                    .onReceive(buttonTimer) { _ in
                        
                        withAnimation {
                            buttonOpacity = 1.0
                        }
                        
                        // Stop the timer
                        buttonTimer.upstream.connect().cancel()
                    }
                    
                    
                }
                
            }
            .navigationTitle("New Jokes")
        }
    }
}
 
#Preview {
    JokeView()
        .environment(JokeViewModel())
}
